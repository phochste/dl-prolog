:- consult('core.pl').

fact(bird(tweety)).
fact(penguin(charles)).

strict(r1,bird(X),penguin(X)).
defeasible(r2,fly(X),bird(X)).
defeater(r3,~(fly(X)),penguin(X)).

run :-
    print_theory() ,
    run_query(pDelta(bird(charles))) ,
    run_query(mDelta(bird(charles))) ,
    run_query(pdelta(fly(charles))) ,
    run_query(mdelta(fly(charles))) .