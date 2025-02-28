:- consult('core.pl').

fact(student(alice)).
fact(course(alice,medicine)).

strict(r1,knowledge,exam(X),[student(X),course(X,medicine)]).

defeasible(r2,permission,diploma(X),exam(X)).

run :-
    run_query(pdelta(graduate(alice),permission)) ,
    run_query(pdelta(graduate(alice),obligation)) ,
    run_query(mdelta(graduate(alice),obligation)) ,
    run_query(pdelta(graduate(bob),permission)) ,
    run_query(pdelta(graduate(bob),obligation)) ,
    run_query(mdelta(graduate(bob),obligation)) .