USE SISDB;

-- TASK 2

-- QUES 1

desc students;

insert into students(first_name, last_name, date_of_birth, email, phone_number)
values('John', 'Doe', '1995-15-08', 'johndoe@example.com', '1234567890');

-- select * from students;

-- Ques 2

-- select * from enrollments;

insert into enrollments(enrollment_id, student_id, course_id, enrollment_date)
values (11, 3, 9, '2020-12-03');

-- Ques 3

-- select * from teacher;

UPDATE teacher
set email = 'poonam@gmail.com'
where teacher_id = 8;

-- Ques 4

-- select * from enrollments;

delete from enrollments
where enrollment_id = 6;

-- Ques 5

-- select * from courses;

update courses
set teacher_id = 1
where course_id = 6;

-- Ques 6

-- select * from students;

delete from students
where student_id = 11;

-- Ques 7

-- select * from payments

update payments
set amount = '47700'
where payment_id = 5;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TASK 3

-- Ques 1

select s.student_id, s.first_name, s.last_name, sum(p.amount) as total_payments
from students s INNER JOIN payments p
on s.student_id = p.student_id
where s.student_id = 1
group by s.student_id;

-- Ques 2

select c.course_id, c.course_name, count(e.student_id)
from courses c LEFT JOIN enrollments e
on c.course_id = e.course_id
group by c.course_id;

-- Ques 3

select s.student_id, s.first_name, s.last_name
from students s LEFT JOIN enrollments e
on s.student_id = e.student_id
where e.student_id is NULL;

-- Ques 4

select s.student_id, s.first_name, s.last_name, c.course_name
from students s LEFT JOIN enrollments e
on s.student_id = e.student_id
INNER JOIN courses c on e.course_id = c.course_id
order by s.student_id;

-- Ques 5

select t.teacher_id, t.first_name, t.last_name, c.course_name
from teacher t LEFT JOIN courses c 
on t.teacher_id = c.teacher_id;

-- Ques 6

select s.first_name, s.last_name, c.course_name, e.enrollment_date
from students s INNER JOIN enrollments e
on s.student_id = e.student_id
INNER JOIN courses c on e.course_id = c.course_id
where c.course_name = 'Data Structure';

-- Ques 7

-- select * from payments;

select s.first_name, s.last_name
from students s LEFT JOIN payments p
on s.student_id = p.student_id
where p.amount is NULL;

-- Ques 8

select c.course_id, c.course_name
from courses c LEFT JOIN enrollments e
on c.course_id = e.course_id
where e.course_id is NULL;

-- Ques 9

select e1.student_id
from enrollments e1 INNER JOIN enrollments e2
on e1.student_id = e2.student_id 
and e1.course_id <> e2.course_id
group by e1.student_id
having count(distinct(e1.course_id)) > 1;

-- Ques 10

select t.teacher_id, t.first_name, t.last_name
from teacher t LEFT JOIN courses c
on t.teacher_id = c.teacher_id
where c.teacher_id is NULL;

-- --------------------------------------------------------------------------------------------------------------------------------------------

-- TASK 4

-- Ques 1

/*
select avg(enrollment_count) AS average_students_per_course
from (
    select course_id, count(student_id) as enrollment_count
    from Enrollments
    group by course_id) 
as course_enrollments;
*/

-- Ques 2

/*
select student_id, first_name, last_name
from students
where student_id in (
    select student_id
    from payments
    where amount = (select max(amount) from payments)
);
*/
-- select * from payments;

-- Ques 3

select course_id, course_name
from courses
where course_id in (
    select course_id
    from enrollments
    group by course_id
    having count(*) = (
        select max(enrollment_count)
        from (
            select course_id, count(*) AS enrollment_count
            from enrollments
            group by course_id
        ) as course_enrollments
    )
);


-- Ques 4



-- Ques 5



-- Ques 6

select teacher_id, first_name, last_name
from teacher
where teacher_id not in (
    select distinct teacher_id
    from Courses
);

-- Ques 7

select avg(timestampdiff(year, date_of_birth, CURDATE())) as average_age
from Students;


-- Ques 8

select course_id, course_name
from Courses
where course_id not in (
    select distinct course_id
    from Enrollments
);

-- QUes 9

select student_id, SUM(amount) as total_payments
from Payments
group by student_id;

-- Ques 10

select student_id, first_name, last_name
from students
where student_id in (
    select student_id
    from payments
    group by student_id
    having count(*) > 1
);

-- Ques 11

select s.student_id, s.first_name, s.last_name, sum(p.amount) as total_payments
from students s left join payments p 
on s.student_id = p.student_id
group by s.student_id, s.first_name, s.last_name;

-- Ques 12

select c.course_name, count(e.student_id) as num_students_enrolled
from courses c left join enrollments e 
on c.course_id = e.course_id
group by c.course_name;

-- Ques 13

select avg(amount) as average_payment_amount
from payments;