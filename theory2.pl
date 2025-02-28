:- consult('core.pl').

fact(professor(herbert)).
fact(visiting(herbert)).
strict(r1,knowledge,faculty(X),professor(X)).
defeasible(r3,knowledge,tenured(X),professor(X)).
defeasible(r4,knowledge,~(tenured(X)),visiting(X)).
superior(r4,r3).