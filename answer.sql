/********************************************************************
 * student_records.sql
 * Simple and Unique Student Record Management Database (MySQL)
 *
 * Demonstrates 1-to-1, 1-to-many, and many-to-many relationships
 * Includes PK, FK, NOT NULL, UNIQUE constraints
 ********************************************************************/

-- Start fresh
DROP DATABASE IF EXISTS student_records;
CREATE DATABASE student_records CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE student_records;

/* ---------------------------
   Core tables
   --------------------------- */

-- Students table
CREATE TABLE students (
    student_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    matric_no VARCHAR(20) NOT NULL UNIQUE,  -- unique identifier e.g., STU2025-001
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    dob DATE,
    gender ENUM('male','female','other') DEFAULT 'other',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Lecturers table
CREATE TABLE lecturers (
    lecturer_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    staff_no VARCHAR(20) NOT NULL UNIQUE,   -- unique staff number e.g., LEC2025-01
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    hire_date DATE NOT NULL
) ENGINE=InnoDB;

-- Courses table (each taught by a lecturer)
CREATE TABLE courses (
    course_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(20) NOT NULL UNIQUE,  -- e.g., CSC101
    course_title VARCHAR(255) NOT NULL,
    credit_unit TINYINT UNSIGNED NOT NULL,
    lecturer_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (lecturer_id) REFERENCES lecturers(lecturer_id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Enrollment table (students <-> courses, many-to-many)
CREATE TABLE enrollments (
    enrollment_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    student_id INT UNSIGNED NOT NULL,
    course_id INT UNSIGNED NOT NULL,
    semester ENUM('First','Second','Summer') NOT NULL,
    session_year VARCHAR(9) NOT NULL,  -- e.g., "2024/2025"
    grade CHAR(2) DEFAULT NULL,        -- e.g., A, B, C, F
    enrolled_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (student_id, course_id, semester, session_year),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
) ENGINE=InnoDB;

