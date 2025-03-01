:- dynamic fact/1 .
:- dynamic strict/3 .
:- dynamic defeasible/3 .
:- dynamic defeater/3 .
:- dynamic superior/2 .
:- discontiguous strictly/1 .
:- discontiguous defeasibly/1.

supportive_rule(Name,Head,Body) :-
	strict(Name,Head,Body) .

supportive_rule(Name,Head,Body) :-
	defeasible(Name,Head,Body) .

rule(Name,Head,Body) :-
	supportive_rule(Name,Head,Body) .

rule(Name,Head,Body) :-
	defeater(Name,Head,Body) .

strictly(P) :- fact(P) .
strictly(P) :- builtin(P) .
strictly(P) :- strict(_,P,B) , strictly(B) .

strictly([]) .
strictly([H|T]) :- 
	debug(trace,"strictly ~w\n", [H]),
	strictly(H) , 
	strictly(T) .

defeasibly(P) :- 
	debug(trace,"defeasibly(strictly) ~w\n", [P]),
	strictly(P). 

defeasibly(P) :- 
	debug(trace,"defeasibly ~w\n", [P]),
	consistent(P) , 
	debug(trace,"--consistent ~w\n", [P]),
	supported(_,P) , 
	debug(trace,"--supported : ~w\n", [P]),
	negation(P,P1) , 
	not(undefeated_applicable(_,P1)) .  

defeasibly([],_). 
defeasibly([H|T]) :- defeasibly(H) , defeasibly(T) . 

consistent(P) :- 
	negation(P,P1) ,
	not(strictly(P1)) .

supported(R,P) :- 
	debug(trace,"supportive ~w?", [P]),
	supportive_rule(R,P,A) ,
	debug(trace,"--supportive_rule ~w for ~w", [R,P]),
	defeasibly(A) .

undefeated_applicable(S,P) :-
	rule(S,P,A) ,
	defeasibly(A) ,
	not(defeated_by_supported(S,P)) , 
	not(defeated_by_applicable(S,P)) . 

defeated_by_supported(R,P) :- 
	negation(P,P1) , supported(S,P1), superior(S,R) .

defeated_by_applicable(R,P) :-
	negation(P,P1), applicable(S,P1), superior(S,R) .

applicable(R,P) :-
	defeater(R,P,A) , 
	defeasibly(A) . 

applicable(R,P) :- 
	supported(R,P) .

defeated(S,P) :- 
	negation(P,P1) , 
	applicable(R,P1) , 
	superior(R,S) .

negation(~(X),X) :- ! . 
negation(X, ~(X)).

%% Buit-ins
builtin(sum(A,B,C)) :-
	C is A + B .

%% Query

pDelta(Q) :- ! , strictly(Q) .
mDelta(Q) :- ! , strictly(~(Q)) .

pdelta(Q) :- ! , defeasibly(Q) .
mdelta(Q) :- ! , defeasibly(~(Q)) .

print_theory() :-
	write("*********************\n"),
	write("Theory\n") ,
	write("*********************\n"),
	theory(),
	write("\n").

theory() :-
	fact(F) ,
	writeln(F) , 
	fail .

theory() :-
	strict(Name,Consequent,Antecedent) ,
	format("~w : ~w -> ~w\n", [Name,Antecedent,Consequent]) ,
	fail .

theory() :-
	defeasible(Name,Consequent,Antecedent) ,
	format("~w : ~w => ~w\n", [Name,Antecedent,Consequent]) ,
	fail .

theory() :-
	defeater(Name,Consequent,Antecedent) ,
	format("~w : ~w ~~> ~w\n", [Name,Antecedent,Consequent]) ,
	fail .

theory() :-
	superior(A,B) ,
	format("~w > ~w\n", [A,B]) ,
	fail .
	
theory() .

run_query(Query) :-
	Query =.. [Functor|[Q|_]] ,
	( Functor = pDelta -> write("+Δ "), write(Q)
	  ; Functor = mDelta -> write("-Δ ") , write(Q) 
	  ; Functor = pdelta -> write("+δ ") , write(Q)
	  ; Functor = mdelta -> write("-δ ") , write(Q)
	),
	write(" := ") , 
    ( call(Query) -> writeln(true) ; writeln(false) ).