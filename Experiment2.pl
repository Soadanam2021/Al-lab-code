% Facts
lectures(codd, cse9020).
lectures(codd, cse9314).
lectures(backus, cse9021).
lectures(ritchie, cse9021).
lectures(minsky, cse9414).
lectures(backus, cse9311).

studies(fred, cse9020).
studies(jack, cse9311).
studies(jill, cse9314).
studies(henry, cse9414).

offered(cse9020, summer).
offered(cse9021, fall).
offered(cse9021, spring).
offered(cse9311, spring).
offered(cse9314, fall).

% Rules
% I. Course lists of any teacher
course_list(Teacher, Course) :-
    lectures(Teacher, Course).

% II. Who is taught by a teacher
taught_by(Student, Teacher) :-
    studies(Student, Course),
    lectures(Teacher, Course).

% III. Fred's summer courses
fred_summer_course(Course) :-
    studies(fred, Course),
    offered(Course, summer).

% IV. Did a teacher teach in summer?
taught_in_summer(Teacher) :-
    lectures(Teacher, Course),
    offered(Course, summer).

% V. Each student's course
student_course(Student, Course) :-
    studies(Student, Course).