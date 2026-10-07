-- Sample data. Run schema.sql first.

INSERT INTO students (student_id, name, email, department, year) VALUES
(1, 'Aarav Sharma',  'aarav@example.com',  'CSE', 2),
(2, 'Diya Verma',    'diya@example.com',   'CSE', 2),
(3, 'Rohan Singh',   'rohan@example.com',  'ECE', 3),
(4, 'Meera Patel',   'meera@example.com',  'ECE', 1),
(5, 'Kabir Khan',    'kabir@example.com',  'ME',  4),
(6, 'Ananya Gupta',  'ananya@example.com', 'CSE', 1),
(7, 'Vikram Rao',    'vikram@example.com', 'ME',  2);

INSERT INTO courses (course_id, course_name, credits, instructor) VALUES
(101, 'Data Structures',     4, 'Dr. Mehta'),
(102, 'Database Systems',    3, 'Dr. Iyer'),
(103, 'Operating Systems',   3, 'Dr. Nair'),
(104, 'Computer Networks',   3, 'Dr. Sen'),
(105, 'Thermodynamics',      4, 'Dr. Bose');

INSERT INTO enrollments (enrollment_id, student_id, course_id, marks) VALUES
(1,  1, 101, 88),
(2,  1, 102, 92),
(3,  2, 101, 76),
(4,  2, 102, 81),
(5,  2, 103, 67),
(6,  3, 103, 58),
(7,  3, 104, 71),
(8,  4, 104, 35),
(9,  5, 105, 79),
(10, 6, 101, NULL),
(11, 6, 102, NULL);
-- Note: student 7 (Vikram) has no enrollments on purpose, to test LEFT JOIN queries.
