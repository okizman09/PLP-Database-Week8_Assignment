# 🎓 Student Record Management System (MySQL)

## 📌 Overview

This project is a **simple and unique relational database** designed to manage student records in an academic institution.
It demonstrates **good database design principles** with proper normalization, constraints, and relationships.

The schema models:

* Students and their personal details.
* Lecturers who teach courses.
* Courses linked to lecturers.
* Enrollments that connect students to courses (with semester, session, and grade tracking).

This project is ideal for **database design assignments**, **learning SQL**, or as a starting point for building a school management system.

---

## 🗂️ Database Schema

### Entities & Relationships

* **Students**: Each student has a unique matriculation number and email.
* **Lecturers**: Each lecturer has a unique staff number and email.
* **Courses**: Each course is assigned to one lecturer (one-to-many relationship).
* **Enrollments**: Connects students and courses in a many-to-many relationship, with additional attributes for semester, session, and grades.

### Relationship Summary

* **One-to-Many**: Lecturer → Courses
* **Many-to-Many**: Students ↔ Courses (via Enrollments)
* **Unique Twist**: Enrollment includes semester + session tracking to prevent duplicates across academic years.

---

## 🛠️ Features

* ✅ **Normalized structure** (up to 3NF).
* ✅ **Data integrity** enforced with `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, and `UNIQUE` constraints.
* ✅ **Automatic timestamps** for record creation.
* ✅ **Support for grading, semesters, and academic sessions**.

---

## 📂 File Structure

```plaintext
student_records/
│
├── student_records.sql   # Main SQL script with database schema
└── README.md             # Documentation (this file)
```

---

## 🚀 Getting Started

### Requirements

* MySQL Server (8.0+ recommended)
* MySQL Workbench or any SQL client

### Installation

1. Clone this repository or download the `.sql` file.
2. Open your MySQL client and run:

   ```sql
   SOURCE path/to/student_records.sql;
   ```
3. Verify the schema:

   ```sql
   SHOW DATABASES;
   USE student_records;
   SHOW TABLES;
   ```

---

## 🧪 Example Queries

### 1. List all courses a student is enrolled in:

```sql
SELECT s.first_name, s.last_name, c.course_code, c.course_title, e.semester, e.session_year
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE s.matric_no = 'STU2025-001';
```

### 2. Get all students in a course:

```sql
SELECT c.course_code, c.course_title, s.first_name, s.last_name, e.semester, e.session_year
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
JOIN students s ON e.student_id = s.student_id
WHERE c.course_code = 'CSC101';
```

### 3. Show GPA-like summary (average grade per student – simplistic):

```sql
SELECT s.first_name, s.last_name, AVG(
    CASE e.grade
        WHEN 'A' THEN 5
        WHEN 'B' THEN 4
        WHEN 'C' THEN 3
        WHEN 'D' THEN 2
        WHEN 'F' THEN 0
    END
) AS GPA
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
GROUP BY s.student_id;
```

---

## 💡 Future Improvements

* Add **departments and faculties** for better course organization.
* Implement **attendance and timetable tracking**.
* Extend **grading system** with GPA/CGPA calculations.
* Add **user roles** (e.g., Admin, Lecturer, Student Portal accounts).

---

## 👨‍💻 Author

Designed and documented by **Okiki**
Feel free to use, extend, and adapt for your own projects.

---
