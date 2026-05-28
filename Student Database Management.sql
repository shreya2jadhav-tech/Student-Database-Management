CREATE DATABASE Students;
Use db_1;
-- Create Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    class VARCHAR(10)
);

-- Create Courses table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    teacher VARCHAR(50)
);

-- Create Marks table
CREATE TABLE Marks (
    mark_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert Students
INSERT INTO Students VALUES
(1, 'Amit Sharma', 20, 'FY'),
(2, 'Priya Patil', 21, 'SY'),
(3, 'Rahul Desai', 19, 'FY'),
(4, 'Sneha Kulkarni', 22, 'TY');

-- Insert Courses
INSERT INTO Courses VALUES
(101, 'Database Systems', 'Prof. Mehta'),
(102, 'Data Science Basics', 'Prof. Rao'),
(103, 'Operating Systems', 'Prof. Iyer');

-- Insert Marks
INSERT INTO Marks VALUES
(1, 1, 101, 85),
(2, 1, 102, 78),
(3, 2, 101, 92),
(4, 2, 103, 88),
(5, 3, 102, 74),
(6, 4, 103, 90);

--  List all students with their courses and marks
SELECT s.name, c.course_name, m.marks
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
JOIN Courses c ON m.course_id = c.course_id;

-- Find average marks per course
SELECT c.course_name, AVG(m.marks) AS avg_marks
FROM Courses c
JOIN Marks m ON c.course_id = m.course_id
GROUP BY c.course_name;

--  Find all students older than 20
SELECT name, age, class
FROM Students
WHERE age > 20;

--  Count how many students are in each class
SELECT class, COUNT(*) AS total_students
FROM Students
GROUP BY class;

--  Show students who scored more than 80 in any course
SELECT s.name, c.course_name, m.marks
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
JOIN Courses c ON m.course_id = c.course_id
WHERE m.marks > 80;

--  List courses with no students enrolled
SELECT c.course_name
FROM Courses c
LEFT JOIN Marks m ON c.course_id = m.course_id
WHERE m.course_id IS NULL;

--  Display average marks of each student across all courses
SELECT s.name, AVG(m.marks) AS avg_marks
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
GROUP BY s.name;

--  Find students who scored below 75 in Data Science Basics
SELECT s.name, m.marks
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
JOIN Courses c ON m.course_id = c.course_id
WHERE c.course_name = 'Data Science Basics' AND m.marks < 75;

--  Show highest and lowest marks in each course
SELECT c.course_name,
       MAX(m.marks) AS highest,
       MIN(m.marks) AS lowest
FROM Courses c
JOIN Marks m ON c.course_id = m.course_id
GROUP BY c.course_name;

--  Rank students by their total marks
SELECT s.name, SUM(m.marks) AS total_marks
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
GROUP BY s.name
ORDER BY total_marks DESC;

--  Find teachers who teach more than one course
SELECT teacher, COUNT(*) AS courses_taught
FROM Courses
GROUP BY teacher
HAVING COUNT(*) > 1;



