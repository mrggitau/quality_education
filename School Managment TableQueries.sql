CREATE TABLE Staff(
staff_id int PRIMARY KEY,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
contact_info VARCHAR(255) NOT NULL,
staff_role VARCHAR(255) NOT NULL,
extra_caricular_role VARCHAR(255) DEFAULT NULL
);

CREATE TABLE Student(
Student_id int PRIMARY KEY,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
date_or_birth DATE,
gender VARCHAR(255) NOT NULL,
student_contact_info  VARCHAR(255) NOT NULL,
guardian_name VARCHAR(255) NOT NULL,
guardian_contact VARCHAR(255) NOT NULL,
enrollment_date DATE
);

CREATE TABLE Teacher(
teacher_id int PRIMARY KEY,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
contact_info VARCHAR(255) NOT NULL
);

CREATE TABLE Course(
course_id int PRIMARY KEY,
course_name VARCHAR(255) NOT NULL,
teacher_id INT,
FOREIGN KEY(teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Grades(
grade VARCHAR(255) NOT NULL,
student_id INT,
course_id INT,
marks_obtained VARCHAR(255) NOT NULL,
PRIMARY KEY(student_id,course_id),
FOREIGN KEY(student_id) REFERENCES Student(student_id),
FOREIGN KEY(course_id) REFERENCES Course(course_id)
);

CREATE TABLE Attendance(
absence_percentage VARCHAR(255) NOT NULL,
student_id INT,
course_id INT,
teacher_id INT,
PRIMARY KEY(student_id,course_id,teacher_id),
FOREIGN KEY(student_id) REFERENCES Student(student_id),
FOREIGN KEY(course_id) REFERENCES Course(course_id),
FOREIGN KEY(teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Fees(
fee_status  VARCHAR(255) NOT NULL,
student_id INT,
amount_due DECIMAL(10,2) DEFAULT NULL,
amount_paid DECIMAL(10,2) NOT NULL,
PRIMARY KEY(student_id),
FOREIGN KEY(student_id) REFERENCES Student(student_id)
);