-- Student Management Database
-- Schema: 3 related tables (students, courses, enrollments) and one view.
-- Written in standard SQL; runs in SQLite and MySQL.

DROP VIEW IF EXISTS student_results;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;

CREATE TABLE students (
    student_id  INT PRIMARY KEY,
    name        VARCHAR(60)  NOT NULL,
    email       VARCHAR(80)  NOT NULL UNIQUE,
    department  VARCHAR(30)  NOT NULL,
    year        INT          NOT NULL CHECK (year BETWEEN 1 AND 4)
);

CREATE TABLE courses (
    course_id    INT PRIMARY KEY,
    course_name  VARCHAR(60) NOT NULL,
    credits      INT         NOT NULL CHECK (credits > 0),
    instructor   VARCHAR(60) NOT NULL
);

-- One row per (student, course). marks stays NULL until the result is declared.
CREATE TABLE enrollments (
    enrollment_id  INT PRIMARY KEY,
    student_id     INT NOT NULL,
    course_id      INT NOT NULL,
    marks          INT CHECK (marks BETWEEN 0 AND 100),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id)  REFERENCES courses(course_id),
    UNIQUE (student_id, course_id)
);

-- A view that joins all three tables and adds a grade.
CREATE VIEW student_results AS
SELECT
    s.student_id,
    s.name,
    s.department,
    c.course_name,
    e.marks,
    CASE
        WHEN e.marks IS NULL THEN 'Pending'
        WHEN e.marks >= 90   THEN 'A'
        WHEN e.marks >= 75   THEN 'B'
        WHEN e.marks >= 60   THEN 'C'
        WHEN e.marks >= 40   THEN 'D'
        ELSE 'F'
    END AS grade
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN courses  c ON c.course_id  = e.course_id;
