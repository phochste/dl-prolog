:- consult('core.pl').

fact(professor(herbert)).
fact(visiting(herbert)).

strict(r1,faculty(X),professor(X)).
defeasible(r2,tenured(X),professor(X)).
defeasible(r3,~(tenured(X)),visiting(X)).
superior(r3,r2).

run :-
    print_theory(),
    run_query(pDelta(faculty(herbert))) ,
    run_query(mDelta(faculty(herbert))) ,
    run_query(pdelta(tenured(herbert))) ,
    run_query(mdelta(tenured(herbert))) .