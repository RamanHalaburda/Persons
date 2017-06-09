USE [Person]
GO

/*
create table students (id integer primary key,
	first_name text,
	last_name text,
	email text,
	phone text,
	birthday text);*/
	
/*
insert into students
	values(1,'владимир', 'щерба', 'vscherba@outlook.com', '2222222', '1993-02-24');
	
insert into students
	values(2,'александр', 'сергеев', 'asergeev@gmail.com', '3333333', '1995-09-21');
	
insert into students
	values(3,'николай', 'тетерин', 'nteterin@outlook.com', '5555555', '1993-11-19');
	
insert into students
	values(4,'василий', 'алексеев', 'valekseev@gmail.com', '7777777', '1994-05-01');*/

/*
create table student_grade (id integer primary key,
	student_id integer,
	test text,
	grade integer);*/

/*
insert into student_grade
	values(1,1,'физика',3);
insert into student_grade
	values(2,2,'математика',8);
insert into student_grade
	values(3,1,'литература',2);
insert into student_grade
	values(4,2,'физика',9);
insert into student_grade
	values(5,1,'математика',5);
insert into student_grade
	values(6,2,'литературы',8);*/

/*
update student_grade set student_id=1 where grade = 9;*/

/* cross join */ /*
select * from student_grade, students;*/

/* implicit inner join */ /*
select * from student_grade, students
	where student_grade.student_id = students.id; */

/* explicit inner join - JOIN */ /*
select students.first_name, students.last_name, students.email, student_grade.test, student_grade.grade 
	from students join student_grade
	on students.id = student_grade.student_id where grade > 5; */

	/*
create table student_projects(id integer primary key,
	student_id integer, title text);

insert into student_projects values(1,1,'о галлактике');*/

/* outer join */ /*
select students.first_name, students.last_name, student_projects.title
	from students
	/*left outer*/ join student_projects
	on students.id = student_projects.student_id;*/

/*
insert into student_projects values(2,2,'диалекты в белорусской культуре');
insert into student_projects values(3,3,'LC-meter на AtTiny 2313');
insert into student_projects values(4,4,'об акцентах');*/

/*
create table project_pairs (id integer primary key,
	project1_id integer,
	project2_id integer);

insert into project_pairs values(1,1,2),(2,3,4);*/

/*
select * from project_pairs;*/

/* multiple join */ /*
select a.title, b.title
	from project_pairs
	join student_projects a 
		on project_pairs.project1_id = a.id
	join student_projects b 
		on project_pairs.project2_id = b.id;*/

/*
select a.last_name, title
	from dbo.students as a inner join dbo.project_pairs
	on (a.id = [project1_id] and  =  [project2_id]);*/
/*
select a.title, b.title
	from project_pairs
	join student_projects a 
		on project_pairs.project1_id = a.id
	join student_projects b 
		on project_pairs.project2_id = b.id;*/

/*select * from students;*/

/*
select a.last_name, b.last_name
	from project_pairs
	join students a 
		on project_pairs.project1_id = a.id
	join students b 
		on project_pairs.project2_id = b.id;*/

/*select * from [dbo].[student_projects];*/

CREATE STATISTICS MyStatFull
    ON [dbo].[project_pairs] ([id],[project1_id], [project2_id]);
GO

CREATE INDEX indexFirst ON [dbo].[project_pairs] ([project1_id]);
CREATE INDEX indexSecond ON [dbo].[project_pairs] ([project2_id]);
GO

SELECT a.last_name, b.last_name, p.title
	FROM project_pairs
	JOIN students a 
		ON project_pairs.project1_id = a.id
	JOIN students b 
		ON project_pairs.project2_id = b.id
	JOIN [dbo].[student_projects] p
		ON project_pairs.id = p.id;
GO

SELECT student_projects.title, students.* 
	FROM students
	JOIN student_projects
		ON student_projects.student_id = students.id;
GO

SELECT * FROM  [dbo].[students]
	WHERE SUBSTRING([birthday], 1, 4) LIKE '1995';
GO

Create PROCEDURE GetStudentsByYear
(
	@year NVARCHAR(4)
)
AS
	BEGIN
		SELECT * FROM  [dbo].[students]
			WHERE SUBSTRING([birthday], 1, 4) LIKE @year
	END
GO

Execute GetStudentsByYear '1993';
GO

SELECT s.*, p.[title] FROM 
[dbo].[student_projects] as p
	CROSS APPLY
		(SELECT * FROM [dbo].[students] as s WHERE p.student_id= s.id) as s;
GO
/*
SELECT * FROM  [dbo].[student_grade] AS G1
	OUTER APPLY
	(SELECT * 
		FROM [dbo].[student_grade] AS G2 
			WHERE G1.test LIKE G2.test) AS G3
			ORDER BY G1.id;
GO*/


/*drop function FooGetStudentsByYear*/
CREATE FUNCTION FooGetStudentsByYear(@id AS INT, @year AS VARCHAR(4))  
RETURNS TABLE 
AS 
RETURN 
   ( 
   SELECT S.last_name, S.email, S.phone FROM [dbo].[students] S 
   WHERE SUBSTRING(S.[birthday], 1, 4) LIKE @year AND S.id = @id   
   ) 
GO 

SELECT * FROM students AS S1
OUTER APPLY FooGetStudentsByYear(S1.id, '1993') 
GO
