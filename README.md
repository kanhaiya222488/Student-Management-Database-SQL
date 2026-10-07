# Student Management Database (SQL)

A relational database design for managing students, courses and exam results, with 12 ready-to-run queries.

## Tables

| Table | Purpose |
|---|---|
| `students` | student details (name, email, department, year) |
| `courses` | course name, credits, instructor |
| `enrollments` | which student took which course, and the marks (links the two tables above) |

A view, `student_results`, joins all three tables and adds a grade (A-F, or *Pending* if marks are not declared yet).

## What it demonstrates

- **Primary keys, foreign keys, UNIQUE and CHECK constraints.** The database rejects duplicate enrollments, marks outside 0-100, unknown students and duplicate emails.
- **JOINs:** INNER JOIN across 3 tables, and LEFT JOIN to find students with no enrollment
- **Aggregation:** `GROUP BY`, `HAVING`, `COUNT`, `AVG`
- **Subqueries**, including a correlated subquery to find the topper of each course
- **Views** and `CASE` expressions
- `INSERT`, `UPDATE`, `DELETE`

## Files

```
schema.sql    creates the tables and the view
data.sql      sample data (7 students, 5 courses, 11 enrollments)
queries.sql   12 example queries
```

## How to run

**Option 1: SQLite (easiest, no setup)**
Open any online SQLite editor (for example sqliteonline.com), then paste and run `schema.sql`, then `data.sql`, then queries from `queries.sql` one at a time.

**Option 2: SQLite command line**
```
sqlite3 college.db
.read schema.sql
.read data.sql
.read queries.sql
```

**Option 3: MySQL**
Run the same three files in order. The SQL is standard, so it works as written.

## Example query and output

Average marks per course:

```sql
SELECT c.course_name, ROUND(AVG(e.marks), 1) AS average_marks
FROM courses c
JOIN enrollments e ON e.course_id = c.course_id
GROUP BY c.course_id, c.course_name
ORDER BY average_marks DESC;
```

| course_name | average_marks |
|---|---|
| Database Systems | 86.5 |
| Data Structures | 82.0 |
| Thermodynamics | 79.0 |
| Operating Systems | 62.5 |
| Computer Networks | 53.0 |

## Possible improvements

- Add a `departments` table and link students to it
- Add attendance and semester tables
- Build a small web or C++ front end on top of the database
