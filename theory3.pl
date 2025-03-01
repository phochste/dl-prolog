:- consult('core.pl').

fact(age(patrick,53)) .

strict(
    r2,
    knowledge,
    answer(B),
    [
        age(patrick,A),
        sum(A,1,B)
    ]).

run :-
    print_theory() ,
    run_query(pDelta(answer(54))) ,
    run_query(mDelta(answer(53))) .