use students___db;

Select * From students;

select * From students where grade > 80 ;

update students set grade = 90 where id = 1;


delete from students where id = 1;

insert into students (id , name , grade) values (1,'jawaad','87');

select * from students where name like 'j%'; 

SELECT * FROM Students ORDER BY grade DESC;

SELECT Students.StudentID, Students.name, Courses.course_name
FROM Students
JOIN Courses ON Students.StudentID = Courses.StudentID;

SELECT AVG(grade) AS average_grade
FROM Students;

SELECT grade, COUNT(*) AS student_count
FROM Students
GROUP BY grade;