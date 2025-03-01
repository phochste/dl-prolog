
:- consult('core.pl').

fact(prerequisites_passed(alice,physics,fall,1990)) .

defeasible(
    r1,
    permission,
    enroll(Student,Lesson,Semester,Year),
    prerequisites_passed(Student,Lesson,Semester,Year)
).

defeasible(
    r2,
    obligation,
    ~(enroll(Student,Lesson,spring,NextYear)),
    [
        enroll(Student,Lesson,fall,Year),
        sum(Year,1,NextYear)
    ]
).

superior(r2,r1).

run :-
    debug(trace),
    print_theory() ,
%    run_query(pdelta(enroll(alice,physics,fall,1990),permission)) ,
    run_query(mdelta(enroll(alice,physics,spring,1991),obligation)) .