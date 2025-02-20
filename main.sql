-- 1. "groups" jadvalini yaratish
CREATE TABLE groups (
    group_id SERIAL PRIMARY KEY,
    group_name VARCHAR(50) UNIQUE,
    max_students INT CHECK (max_students BETWEEN 5 AND 30)
);

-- 2. "students" jadvalini yaratish
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE CHECK (birth_date < '2010-01-01'),
    group_id INT REFERENCES groups(group_id)
);

-- 3. "teachers" jadvalini yaratish
CREATE TABLE teachers (
    teacher_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F'))
);

-- 4. "subjects" jadvalini yaratish
CREATE TABLE subjects (
    subject_id SERIAL PRIMARY KEY,
    subject_name VARCHAR(100) UNIQUE,
    teacher_id INT REFERENCES teachers(teacher_id)
);

-- 5. "groups" jadvaliga ma'lumot kiritish
INSERT INTO groups (group_name, max_students) VALUES
    ('Alpha', 10),
    ('Beta', 15),
    ('Gamma', 20),
    ('Delta', 25),
    ('Epsilon', 30);

-- 6. "students" jadvaliga ma'lumot kiritish
INSERT INTO students (first_name, last_name, birth_date, group_id) VALUES
    ('Ali', 'Vohidov', '2005-06-15', 1),
    ('Bobur', 'Karimov', '2004-03-22', 1),
    ('Dilnoza', 'Xolmatova', '2003-07-12', 2),
    ('Farhod', 'Ismoilov', '2002-09-05', 2),
    ('Gulnora', 'Rahimova', '2001-11-30', 3),
    ('Hasan', 'Turgunov', '2000-01-17', 3),
    ('Iroda', 'Mirzayeva', '2006-05-10', 4),
    ('Jasur', 'Bekmurodov', '2007-08-21', 4),
    ('Kamola', 'Ergasheva', '2008-02-13', 5),
    ('Laziz', 'Olimov', '2009-12-29', 5);

-- 7. "teachers" jadvaliga ma'lumot kiritish
INSERT INTO teachers (first_name, last_name, gender) VALUES
    ('Olim', 'Usmonov', 'M'),
    ('Nodira', 'Salimova', 'F'),
    ('Rustam', 'Holikov', 'M'),
    ('Malika', 'Norqobilova', 'F'),
    ('Abdulla', 'Tursunov', 'M');

-- 8. "subjects" jadvaliga ma'lumot kiritish
INSERT INTO subjects (subject_name, teacher_id) VALUES
    ('Matematika', 1),
    ('Fizika', 2),
    ('Informatika', 3),
    ('Kimyo', 4),
    ('Biologiya', 5),
    ('Tarix', 1);

-- 9. "enrollments" jadvalini yaratish
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    subject_id INT REFERENCES subjects(subject_id),
    enroll_date DATE NOT NULL,
    grade INT CHECK (grade BETWEEN 1 AND 5)
);

-- 10. "enrollments" jadvaliga ma'lumot kiritish
INSERT INTO enrollments (student_id, subject_id, enroll_date, grade) VALUES
    (1, 1, '2024-01-10', 5),
    (2, 2, '2024-01-12', 4),
    (3, 3, '2024-01-15', 3),
    (4, 4, '2024-01-20', 2),
    (5, 5, '2024-01-22', 1),
    (6, 6, '2024-02-01', 5),
    (7, 1, '2024-02-10', 4),
    (8, 2, '2024-02-12', 3),
    (9, 3, '2024-02-15', 2),
    (10, 4, '2024-02-20', 1);

-- 11. UPDATE bilan ma’lumotni yangilash
UPDATE students SET group_id = 3 WHERE student_id = 1;

-- 12. DELETE bilan ma’lumotni o‘chirish
DELETE FROM subjects WHERE subject_id = 5;
DELETE FROM students WHERE student_id = 10;

-- 13. INNER JOIN misoli
SELECT students.first_name, students.last_name, groups.group_name 
FROM students 
INNER JOIN groups ON students.group_id = groups.group_id;

-- 14. LEFT JOIN misoli
SELECT subjects.subject_name, teachers.first_name, teachers.last_name 
FROM subjects 
LEFT JOIN teachers ON subjects.teacher_id = teachers.teacher_id;

-- 15. RIGHT JOIN misoli
SELECT groups.group_name, students.first_name, students.last_name 
FROM students 
RIGHT JOIN groups ON students.group_id = groups.group_id;

-- 16. GROUP BY va HAVING
SELECT group_id, COUNT(*) 
FROM students 
GROUP BY group_id 
HAVING COUNT(*) > 5;

-- 17. ON DELETE CASCADE sinovi
ALTER TABLE students DROP CONSTRAINT students_group_id_fkey;
ALTER TABLE students ADD CONSTRAINT students_group_id_fkey FOREIGN KEY (group_id) REFERENCES groups(group_id) ON DELETE CASCADE;

-- 18. ON UPDATE CASCADE sinovi
ALTER TABLE subjects DROP CONSTRAINT subjects_teacher_id_fkey;
ALTER TABLE subjects ADD CONSTRAINT subjects_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id) ON UPDATE CASCADE;

-- 19. Bir nechta JOIN kombinasiyasi
SELECT students.first_name, students.last_name, subjects.subject_name, teachers.first_name AS teacher_first, teachers.last_name AS teacher_last 
FROM students 
JOIN enrollments ON students.student_id = enrollments.student_id 
JOIN subjects ON enrollments.subject_id = subjects.subject_id 
JOIN teachers ON subjects.teacher_id = teachers.teacher_id;

-- 20. ORDER BY va LIMIT
SELECT * FROM enrollments ORDER BY grade DESC LIMIT 5;

-- 21. OFFSET va FETCH
SELECT * FROM students OFFSET 5 FETCH NEXT 3 ROWS ONLY;

-- 22. LIKE operatori
SELECT * FROM students WHERE first_name LIKE '%a%';

-- 23. IN operatori
SELECT * FROM students WHERE group_id IN (1, 3, 5, 7, 9);

-- 24. BETWEEN operatori
SELECT * FROM students WHERE birth_date BETWEEN '2000-01-01' AND '2005-12-31';

-- 25. EXISTS operatori
SELECT * FROM students WHERE EXISTS (SELECT * FROM enrollments WHERE students.student_id = enrollments.student_id AND grade = 5);