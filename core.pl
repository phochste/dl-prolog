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
strictly(P,intention) :- fact(intention(P)) .
strictly(P,agency) :- fact(agency(P)) .
strictly(P,permission) :- fact(permission(P)) .
strictly(P,Operator) :- strict(_,Operator,P,B) , strictly(B,Operator) .

strictly([]) .
strictly([H|T]) :- strictly(H) , strictly(T) .
strictly(obligation(P)) :- strictly(P,obligation) .
strictly(intention(P)) :- strictly(P,intention) .
strictly(agency(P)) :- strictly(P,agency) . 
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
defeasibly(agency(A)) :- defeasibly(A,agency) . 
defeasibly(intention(A)) :- defeasibly(A,intention) . 
defeasibly(permission(A)) :- defeasibly(A,permission) . 
defeasibly(P) :- defeasibly(P,knowledge) .

consistent(P,knowledge) :- 
	negation(P,P1) ,
	not(strictly(P1,knowledge)) , 
	not(strictly(P1,agency)) .

consistent(P,obligation) :-
	negation(P,P1) ,
	not(strictly(P1,knowledge)) ,
	not(strictly(P1,obligation)) , 
	not(strictly(P1,permission)) .

consistent(P,permission) :- 
	negation(P,P1) , 
	not(strictly(P1,knowledge)) , 
	not(strictly(P1,obligation)) . 

consistent(P,intention) :-
	negation(P,P1) , 
	not(strictly(P1,knowledge)) , 
	not(strictly(P1,intention)) , 
	not(strictly(P1,agency)) .  
	
consistent(P,agency) :-
	negation(P,P1) , 
	not(strictly(P1,knowledge)) , 
	not(strictly(P1,intention)) , 
	not(strictly(P1,agency)) .

consistent(P,intention) :-
	negation(P,P1) ,
	not(strictly(P1,knowledge)) , 
	not(strictly(P1,intention)) , 
	not(strictly(P1,agency)) , 
	not(strictly(P1,obligation)) .  

consistent(P,agency) :-
	negation(P,P1) ,
	not(strictly(P1,knowledge)) , 
	not(strictly(P1,intention)) , 
	not(strictly(P1,agency)) , 
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

undefeated_applicable(S,agency,P) :-
	rule(S,knowledge,P,A) , 
	defeasibly(A) ,
	not(defeated_by_supported(S,agency,P)) , 
	not(defeated_by_applicable(S,knowledge,P)) . 

undefeated_applicable(S,agency,P) :-
	rule(S,agency,P,A) ,
	defeasibly(A) , 
	not(defeated_by_supported(S,agency,P)) , 
	not(defeated_by_applicable(S,agency,P)) . 

undefeated_applicable(S,agency,P) :-
	rule(S,intention,P,A) , 
	defeasibly(A) , 
	not(defeated_by_supported(S,agency,P)) , 
	not(defeated_by_applicable(S,intention,P)) .
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

strictly(P,knowledge) :- strictly(P,agency) . 

defeasibly(P,knowledge) :- defeasibly(P,agency) .

negation(~(X),X) :- ! . 
negation(X, ~(X)).
