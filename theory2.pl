:- consult('core.pl').

fact(professor(herbert)).
fact(visiting(herbert)).
strict(r1,knowledge,faculty(X),professor(X)).
defeasible(r3,knowledge,tenured(X),professor(X)).
defeasible(r4,knowledge,~(tenured(X)),visiting(X)).
defeater(r5,knowledge,~(paid(X)),tenured(X)).
superior(r3,r4).