--THESE ARE THE TABLES WE SAW WOULD BE PERFECT

CREATE TABLE Staff(
staff_id int PRIMARY KEY,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
contact_info VARCHAR(255) NOT NULL,
staff_role VARCHAR(255) NOT NULL,
extra_curricular_role VARCHAR(255) DEFAULT NULL
);

CREATE TABLE Student(
Student_id int PRIMARY KEY,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
date_of_birth DATE,
gender VARCHAR(255) NOT NULL,
student_contact_info  VARCHAR(255) NOT NULL,
guardian_name VARCHAR(255) NOT NULL,
guardian_contact VARCHAR(255) NOT NULL,
enrollment_date DATE,
extra_curricular_activity VARCHAR(255) DEFAULT NULL
);

CREATE TABLE Teacher(
teacher_id int PRIMARY KEY,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
contact_info VARCHAR(255) NOT NULL,
extra_curricular_role VARCHAR(255) DEFAULT NULL
);

CREATE TABLE Course(
course_id int PRIMARY KEY,
course_name VARCHAR(255) NOT NULL,
teacher_id INT,
FOREIGN KEY(teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Grades(
grade VARCHAR(255) NOT NULL, --tracked yearly
student_id INT,
course_id INT,
year INT,
marks_obtained VARCHAR(255) NOT NULL,
PRIMARY KEY(student_id,course_id,year),
FOREIGN KEY(student_id) REFERENCES Student(student_id),
FOREIGN KEY(course_id) REFERENCES Course(course_id)
);

CREATE TABLE Attendance(
absence_percentage VARCHAR(255) NOT NULL, -- tracked yearly
student_id INT,
course_id INT,
teacher_id INT,
PRIMARY KEY(student_id,course_id,teacher_id),
FOREIGN KEY(student_id) REFERENCES Student(student_id),
FOREIGN KEY(course_id) REFERENCES Course(course_id),
FOREIGN KEY(teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Fees(
fee_status  VARCHAR(255) NOT NULL,     -- tracked yearly
student_id INT,
year INT,
amount_due DECIMAL(10,2) DEFAULT NULL,
amount_paid DECIMAL(10,2) NOT NULL,
PRIMARY KEY(student_id,year),
FOREIGN KEY(student_id) REFERENCES Student(student_id)
);

CREATE TABLE Extracurricular_Activity (
activity_id INT PRIMARY KEY,
activity_name VARCHAR(255),
description TEXT,
teacher_id INT, --the patron in charge
FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Scholarship_Donor (
scholarship_donor_id INT PRIMARY KEY,
scholarship_donor_name VARCHAR(255),
description TEXT
);

CREATE TABLE Scholarship (
scholarship_id INT PRIMARY KEY,
scholarship_donor_id INT,
student_id INT,
eligibility_reason TEXT,
FOREIGN KEY (scholarship_donor_id) REFERENCES Scholarship_Donor(scholarship_donor_id),
FOREIGN KEY (student_id) REFERENCES Student(student_id)
);



