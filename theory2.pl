:- consult('core.pl').

fact(professor(herbert)).
fact(visiting(herbert)).
strict(r1,knowledge,faculty(X),professor(X)).
defeasible(r3,knowledge,tenured(X),professor(X)).
defeasible(r4,knowledge,~(tenured(X)),visiting(X)).
superior(r4,r3).

run :-
    run_query(pDelta(faculty(herbert))) ,
    run_query(mDelta(faculty(herbert))) ,
    run_query(pdelta(tenured(herbert))) ,
    run_query(mdelta(tenured(herbert))) .