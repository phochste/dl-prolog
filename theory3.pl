:- consult('core.pl').

fact(age(patrick,53)) .

strict(
    r2,
    answer(B),
    [
        sum(B,-1,A),
        age(patrick,A)
    ]).

run :-
    print_theory() ,
    run_query(pDelta(answer(54))) ,
    run_query(mDelta(answer(53))) .