:- consult('core.pl').

fact(student(alice)).
fact(course(alice,medicine)).

strict(r1,knowledge,exam(X),[student(X),course(X,medicine)]).

defeasible(r2,permission,diploma(X),exam(X)).

run :-
    run_query(pdelta(diploma(alice),permission)) .