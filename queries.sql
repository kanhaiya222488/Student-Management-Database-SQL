-- Useful queries on the Student Management Database.
-- Run schema.sql and data.sql first.

-- 1. All students of one department, sorted by name
SELECT * FROM students WHERE department = 'CSE' ORDER BY name;

-- 2. Which student is enrolled in which course (JOIN of 3 tables)
SELECT s.name, c.course_name, e.marks
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN courses  c ON c.course_id  = e.course_id
ORDER BY s.name, c.course_name;

-- 3. Average marks per course (ignores pending results automatically)
SELECT c.course_name, ROUND(AVG(e.marks), 1) AS average_marks, COUNT(e.marks) AS results_declared
FROM courses c
JOIN enrollments e ON e.course_id = c.course_id
GROUP BY c.course_id, c.course_name
ORDER BY average_marks DESC;

-- 4. Number of students in each department
SELECT department, COUNT(*) AS total_students
FROM students
GROUP BY department
ORDER BY total_students DESC;

-- 5. Students with no enrollment at all (LEFT JOIN + NULL check)
SELECT s.student_id, s.name
FROM students s
LEFT JOIN enrollments e ON e.student_id = s.student_id
WHERE e.enrollment_id IS NULL;

-- 6. Students whose average marks are above 75 (GROUP BY + HAVING)
SELECT s.name, ROUND(AVG(e.marks), 1) AS average_marks
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
GROUP BY s.student_id, s.name
HAVING AVG(e.marks) > 75
ORDER BY average_marks DESC;

-- 7. Marks above the overall average (subquery)
SELECT s.name, c.course_name, e.marks
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN courses  c ON c.course_id  = e.course_id
WHERE e.marks > (SELECT AVG(marks) FROM enrollments)
ORDER BY e.marks DESC;

-- 8. Topper of each course (correlated subquery)
SELECT c.course_name, s.name, e.marks
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN courses  c ON c.course_id  = e.course_id
WHERE e.marks = (SELECT MAX(marks) FROM enrollments WHERE course_id = e.course_id)
ORDER BY c.course_name;

-- 9. Failed results, using the view
SELECT name, course_name, marks FROM student_results WHERE grade = 'F';

-- 10. Grade report, using the view
SELECT name, course_name, marks, grade FROM student_results ORDER BY name, course_name;

-- 11. UPDATE: declare a pending result
UPDATE enrollments SET marks = 84 WHERE student_id = 6 AND course_id = 101;

-- 12. DELETE: remove one enrollment
DELETE FROM enrollments WHERE student_id = 6 AND course_id = 102;
