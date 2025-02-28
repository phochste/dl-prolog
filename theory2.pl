:- consult('core.pl').

fact(professor(herbert)).
fact(visiting(herbert)).
strict(r1,knowledge,faculty(X),professor(X)).
defeasible(r2,knowledge,tenured(X),professor(X)).
defeasible(r3,knowledge,~(tenured(X)),visiting(X)).
superior(r3,r2).

run :-
    run_query(pDelta(faculty(herbert))) ,
    run_query(mDelta(faculty(herbert))) ,
    run_query(pdelta(tenured(herbert))) ,
    run_query(mdelta(tenured(herbert))) .