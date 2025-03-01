:- consult('core.pl').

fact(age(patrick,53)) .

strict(
    r1,
    knowledge,
    answer(B),
    [
        age(patrick,A),
        sum(A,1,B)
    ]).

run :-
    run_query(pDelta(answer(54))) ,
    run_query(mDelta(answer(53))) .