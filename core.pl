:- dynamic strict/4 .
:- dynamic defeater/4 .
:- dynamic superior/2 .
:- discontiguous strictly/2 .
:- discontiguous defeasibly/2.

supportive_rule(Name,Operator,Head,Body) :-
	strict(Name,Operator,Head,Body) .

supportive_rule(Name,Operator,Head,Body) :-
	defeasible(Name,Operator,Head,Body) .

rule(Name,Operator,Head,Body) :-
	supportive_rule(Name,Operator,Head,Body) .

rule(Name,Operator,Head,Body) :-
	defeater(Name,Operator,Head,Body) .

strictly(P,knowledge) :- fact(P) .
strictly(P,obligation) :- fact(obligation(P)) .
strictly(P,permission) :- fact(permission(P)) .
strictly(P,Operator) :- strict(_,Operator,P,B) , strictly(B,Operator) .

strictly([],_) .
strictly([H|T],Operator) :- strictly(H,Operator) , strictly(T,Operator) .
strictly(obligation(P)) :- strictly(P,obligation) .
strictly(permission(P)) :- strictly(P,permission) . 
strictly(P) :- strictly(P,knowledge) .

defeasibly(P,Operator) :- strictly(P,Operator). 
defeasibly(P,Operator) :- 
	consistent(P,Operator) , 
	supported(_,Operator,P) , 
	negation(P,P1) , 
	not(undefeated_applicable(_,Operator,P1)) .  

defeasibly([]). 
defeasibly([H|T]) :- defeasibly(H) , defeasibly(T) . 
defeasibly(obligation(A)) :- defeasibly(A,obligation) . 
defeasibly(permission(A)) :- defeasibly(A,permission) . 
defeasibly(P) :- defeasibly(P,knowledge) .

consistent(P,knowledge) :- 
	negation(P,P1) ,
	not(strictly(P1,knowledge)) .

consistent(P,obligation) :-
	negation(P,P1) ,
	not(strictly(P1,knowledge)) ,
	not(strictly(P1,obligation)) , 
	not(strictly(P1,permission)) .

consistent(P,permission) :- 
	negation(P,P1) , 
	not(strictly(P1,knowledge)) , 
	not(strictly(P1,obligation)) . 

%%% supported %%%
% A literal is supported, if it is supported by by a supported rule with the same
% mode, the premises of which are defeasibly provable
supported(R,Operator,P) :- 
	supportive_rule(R,Operator,P,A) ,
	defeasibly(A) .

% A literal in obligation can be supported by a supported rule in knowledge
supported(R,obligation,P) :-
	supportive_rule(R,knowledge,P,B) , 
	obligation_environment(B) .

obligation_environment(A) :- 
	defeasibly(A,obligation) . 

obligation_environment(obligation(A)) :-
	defeasibly(A,obligation) . 

obligation_environment([A1|A2]) :-
	obligation_environment(A1) , 
	obligation_environment(A2) . 

obligation_environment([]).
%%% end supported %%%

%%% undefeated_applicable %%%
undefeated_applicable(S,knowledge,P) :-
	rule(S,knowledge,P,A) ,
	defeasibly(A) ,
	not(defeated_by_supported(S,knowledge,P)) , 
	not(defeated_by_applicable(S,knowledge,P)) . 

undefeated_applicable(S,permission,P) :-
	rule(S,permission,P,A) ,
	defeasibly(A) ,
	not(defeated_by_supported(S,permission,P)) , 
	not(defeated_by_applicable(S,permission,P)) . 

undefeated_applicable(S,obligation,P) :-
	rule(S,obligation,P,A) ,
	defeasibly(A) ,
	not(defeated_by_supported(S,obligation,P)) , 
	not(defeated_by_applicable(S,obligation,P)) . 
%%% end undefeated_applicable %%%

defeated_by_supported(R,X,P) :- 
	negation(P,P1) , supported(S,X,P1), superior(S,R) .

defeated_by_applicable(R,X,P) :-
	negation(P,P1), applicable(S,X,P1), superior(S,R) .

%%% applicable %%%
% A rule is applicable if there is any rule (supportive or defeator) for this modality
% that is premises are defeasibly provable (even if it is from a different modality
% using rule conversion)
applicable(R,Operator,P) :-
	defeater(R,Operator,P,A) , 
	defeasibly(A) . 

applicable(R,Operator,P) :- 
	supported(R,Operator,P) .
%%% end applicable %%%

%%% defeated %%%
defeated(S,Operator,P) :- 
	negation(P,P1) , 
	applicable(R,Operator,P1) , 
	superior(R,S) .
%%% end defeated %%%

negation(~(X),X) :- ! . 
negation(X, ~(X)).

%% Query

pDelta(Q) :- ! , strictly(Q) .
mDelta(Q) :- ! , strictly(~(Q)) .

pDelta(Q,O) :- ! , strictly(Q,O) .
mDelta(Q,O) :- ! , strictly(~(Q,O)) .

pdelta(Q) :- ! , defeasibly(Q) .
mdelta(Q) :- ! , defeasibly(~(Q)) .

pdelta(Q,O) :- ! , defeasibly(Q,O) .
mdelta(Q,O) :- ! , defeasibly(~(Q),O) .

run_query(Query) :-
	write(Query) ,
	write(" := ") , 
    ( call(Query) -> writeln(true) ; writeln(false) ).