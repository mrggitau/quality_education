--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 16.8

-- Started on 2025-04-11 20:35:28

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.scholarship DROP CONSTRAINT scholarship_student_id_fkey;
ALTER TABLE ONLY public.scholarship DROP CONSTRAINT scholarship_scholarship_donor_id_fkey;
ALTER TABLE ONLY public.grades DROP CONSTRAINT grades_student_id_fkey;
ALTER TABLE ONLY public.grades DROP CONSTRAINT grades_course_id_fkey;
ALTER TABLE ONLY public.fees DROP CONSTRAINT fees_student_id_fkey;
ALTER TABLE ONLY public.extracurricular_activity DROP CONSTRAINT extracurricular_activity_teacher_id_fkey;
ALTER TABLE ONLY public.course DROP CONSTRAINT course_teacher_id_fkey;
ALTER TABLE ONLY public.attendance DROP CONSTRAINT attendance_teacher_id_fkey;
ALTER TABLE ONLY public.attendance DROP CONSTRAINT attendance_student_id_fkey;
ALTER TABLE ONLY public.attendance DROP CONSTRAINT attendance_course_id_fkey;
ALTER TABLE ONLY public.teacher DROP CONSTRAINT teacher_pkey;
ALTER TABLE ONLY public.student DROP CONSTRAINT student_pkey;
ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_pkey;
ALTER TABLE ONLY public.scholarship DROP CONSTRAINT scholarship_pkey;
ALTER TABLE ONLY public.scholarship_donor DROP CONSTRAINT scholarship_donor_pkey;
ALTER TABLE ONLY public.grades DROP CONSTRAINT grades_pkey;
ALTER TABLE ONLY public.fees DROP CONSTRAINT fees_pkey;
ALTER TABLE ONLY public.extracurricular_activity DROP CONSTRAINT extracurricular_activity_pkey;
ALTER TABLE ONLY public.course DROP CONSTRAINT course_pkey;
ALTER TABLE ONLY public.attendance DROP CONSTRAINT attendance_pkey;
DROP TABLE public.teacher;
DROP TABLE public.student;
DROP TABLE public.staff;
DROP TABLE public.scholarship_donor;
DROP TABLE public.scholarship;
DROP TABLE public.grades;
DROP TABLE public.fees;
DROP TABLE public.extracurricular_activity;
DROP TABLE public.course;
DROP TABLE public.attendance;
DROP SCHEMA public;
--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4962 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 33536)
-- Name: attendance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attendance (
    absence_percentage character varying(255) NOT NULL,
    student_id integer NOT NULL,
    course_id integer NOT NULL,
    teacher_id integer NOT NULL
);


ALTER TABLE public.attendance OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 33509)
-- Name: course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course (
    course_id integer NOT NULL,
    course_name character varying(255) NOT NULL,
    teacher_id integer
);


ALTER TABLE public.course OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 33567)
-- Name: extracurricular_activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.extracurricular_activity (
    activity_id integer NOT NULL,
    activity_name character varying(255),
    description text,
    teacher_id integer
);


ALTER TABLE public.extracurricular_activity OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 33556)
-- Name: fees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fees (
    fee_status character varying(255) NOT NULL,
    student_id integer NOT NULL,
    year integer NOT NULL,
    amount_due numeric(10,2) DEFAULT NULL::numeric,
    amount_paid numeric(10,2) NOT NULL
);


ALTER TABLE public.fees OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 33519)
-- Name: grades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grades (
    grade character varying(255) NOT NULL,
    student_id integer NOT NULL,
    course_id integer NOT NULL,
    year integer NOT NULL,
    marks_obtained character varying(255) NOT NULL
);


ALTER TABLE public.grades OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 33586)
-- Name: scholarship; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scholarship (
    scholarship_id integer NOT NULL,
    scholarship_donor_id integer,
    student_id integer,
    eligibility_reason text
);


ALTER TABLE public.scholarship OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 33579)
-- Name: scholarship_donor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scholarship_donor (
    scholarship_donor_id integer NOT NULL,
    scholarship_donor_name character varying(255),
    description text
);


ALTER TABLE public.scholarship_donor OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 33485)
-- Name: staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff (
    staff_id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    contact_info character varying(255) NOT NULL,
    staff_role character varying(255) NOT NULL,
    extra_curricular_role character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.staff OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 33493)
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    student_id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    date_of_birth date,
    gender character varying(255) NOT NULL,
    student_contact_info character varying(255) NOT NULL,
    guardian_name character varying(255) NOT NULL,
    guardian_contact character varying(255) NOT NULL,
    enrollment_date date,
    extra_curricular_activity character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.student OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 33501)
-- Name: teacher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teacher (
    teacher_id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    contact_info character varying(255) NOT NULL,
    extra_curricular_role character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.teacher OWNER TO postgres;

--
-- TOC entry 4952 (class 0 OID 33536)
-- Dependencies: 220
-- Data for Name: attendance; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.attendance VALUES ('10', 101, 1234, 45);
INSERT INTO public.attendance VALUES ('31', 102, 5678, 47);
INSERT INTO public.attendance VALUES ('29', 103, 1234, 45);


--
-- TOC entry 4950 (class 0 OID 33509)
-- Dependencies: 218
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.course VALUES (1234, 'INTERNATIONAL RELATIONS', 47);
INSERT INTO public.course VALUES (5678, 'BBIT', 45);


--
-- TOC entry 4954 (class 0 OID 33567)
-- Dependencies: 222
-- Data for Name: extracurricular_activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.extracurricular_activity VALUES (99, 'Boxing', 'Fighters are here', 48);
INSERT INTO public.extracurricular_activity VALUES (98, 'Chess', 'Smart kids zone', 45);
INSERT INTO public.extracurricular_activity VALUES (97, 'Economics', 'leaders of tomorrow', 47);


--
-- TOC entry 4953 (class 0 OID 33556)
-- Dependencies: 221
-- Data for Name: fees; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.fees VALUES ('CLEARED', 101, 2024, NULL, 5000.00);
INSERT INTO public.fees VALUES ('NOT CLEARED', 102, 2025, 1000.00, 4000.00);
INSERT INTO public.fees VALUES ('CLEARED', 103, 2025, NULL, 5000.00);


--
-- TOC entry 4951 (class 0 OID 33519)
-- Dependencies: 219
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.grades VALUES ('A', 101, 1234, 2024, '499');
INSERT INTO public.grades VALUES ('D', 102, 5678, 2025, '399');
INSERT INTO public.grades VALUES ('B', 103, 1234, 2025, '449');


--
-- TOC entry 4956 (class 0 OID 33586)
-- Dependencies: 224
-- Data for Name: scholarship; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.scholarship VALUES (999, 2, 101, 'He is the best');
INSERT INTO public.scholarship VALUES (888, 1, 102, 'We are hopeful he will make it');


--
-- TOC entry 4955 (class 0 OID 33579)
-- Dependencies: 223
-- Data for Name: scholarship_donor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.scholarship_donor VALUES (1, 'Equator Bank', 'Best BANK ever');
INSERT INTO public.scholarship_donor VALUES (2, 'Mr. Gitau', 'Not part of a foundation, private donor');
INSERT INTO public.scholarship_donor VALUES (3, 'Red cross', 'Most successful donors');


--
-- TOC entry 4947 (class 0 OID 33485)
-- Dependencies: 215
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.staff VALUES (33, 'Fridah', 'Johnte', '0777777777', 'Groundsman', NULL);
INSERT INTO public.staff VALUES (44, 'Justus', 'Walter', '0788888888', 'Sweeper', 'Boxing club deputy');
INSERT INTO public.staff VALUES (55, 'Guhena', 'Trufena', '0769696969', 'Councellor', NULL);


--
-- TOC entry 4948 (class 0 OID 33493)
-- Dependencies: 216
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.student VALUES (101, 'Mark', 'Gitau', '2003-01-09', 'M', '0758178385', 'Harry Morgan', '0788888888', '2023-01-09', 'Boxing captain');
INSERT INTO public.student VALUES (102, 'Harriet', 'Hurruey', '2004-01-09', 'F', '0723560472', 'Faruk Abdullah', '0756472930', '2023-01-11', NULL);
INSERT INTO public.student VALUES (103, 'Jerry', 'Niva', '2005-01-09', 'M', '0777356283', 'Gudang Mursal', '0707070707', '2024-01-09', NULL);


--
-- TOC entry 4949 (class 0 OID 33501)
-- Dependencies: 217
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.teacher VALUES (45, 'Patrick', 'Kamau', '0712345678', 'Chess patron');
INSERT INTO public.teacher VALUES (46, 'Susan', 'Kamakis', '0712367839', NULL);
INSERT INTO public.teacher VALUES (47, 'Donald', 'Trump', '0711111111', 'Economics club patron');
INSERT INTO public.teacher VALUES (48, 'Deralgo', 'Batista', '0799999999', 'Boxing club patron');
INSERT INTO public.teacher VALUES (561, 'Gracey', 'Kamande', '0789263562', 'Drama Club Patron');
INSERT INTO public.teacher VALUES (52222, 'Gracey', 'Kamande', '0789263562', 'Drama Club Patron');


--
-- TOC entry 4785 (class 2606 OID 33540)
-- Name: attendance attendance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_pkey PRIMARY KEY (student_id, course_id, teacher_id);


--
-- TOC entry 4781 (class 2606 OID 33513)
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (course_id);


--
-- TOC entry 4789 (class 2606 OID 33573)
-- Name: extracurricular_activity extracurricular_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.extracurricular_activity
    ADD CONSTRAINT extracurricular_activity_pkey PRIMARY KEY (activity_id);


--
-- TOC entry 4787 (class 2606 OID 33561)
-- Name: fees fees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fees
    ADD CONSTRAINT fees_pkey PRIMARY KEY (student_id, year);


--
-- TOC entry 4783 (class 2606 OID 33525)
-- Name: grades grades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (student_id, course_id, year);


--
-- TOC entry 4791 (class 2606 OID 33585)
-- Name: scholarship_donor scholarship_donor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_donor
    ADD CONSTRAINT scholarship_donor_pkey PRIMARY KEY (scholarship_donor_id);


--
-- TOC entry 4793 (class 2606 OID 33592)
-- Name: scholarship scholarship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship
    ADD CONSTRAINT scholarship_pkey PRIMARY KEY (scholarship_id);


--
-- TOC entry 4775 (class 2606 OID 33492)
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (staff_id);


--
-- TOC entry 4777 (class 2606 OID 33500)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);


--
-- TOC entry 4779 (class 2606 OID 33508)
-- Name: teacher teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (teacher_id);


--
-- TOC entry 4797 (class 2606 OID 33546)
-- Name: attendance attendance_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(course_id);


--
-- TOC entry 4798 (class 2606 OID 33541)
-- Name: attendance attendance_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(student_id);


--
-- TOC entry 4799 (class 2606 OID 33551)
-- Name: attendance attendance_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teacher(teacher_id);


--
-- TOC entry 4794 (class 2606 OID 33514)
-- Name: course course_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teacher(teacher_id);


--
-- TOC entry 4801 (class 2606 OID 33574)
-- Name: extracurricular_activity extracurricular_activity_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.extracurricular_activity
    ADD CONSTRAINT extracurricular_activity_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teacher(teacher_id);


--
-- TOC entry 4800 (class 2606 OID 33562)
-- Name: fees fees_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fees
    ADD CONSTRAINT fees_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(student_id);


--
-- TOC entry 4795 (class 2606 OID 33531)
-- Name: grades grades_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(course_id);


--
-- TOC entry 4796 (class 2606 OID 33526)
-- Name: grades grades_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(student_id);


--
-- TOC entry 4802 (class 2606 OID 33593)
-- Name: scholarship scholarship_scholarship_donor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship
    ADD CONSTRAINT scholarship_scholarship_donor_id_fkey FOREIGN KEY (scholarship_donor_id) REFERENCES public.scholarship_donor(scholarship_donor_id);


--
-- TOC entry 4803 (class 2606 OID 33598)
-- Name: scholarship scholarship_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship
    ADD CONSTRAINT scholarship_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(student_id);


-- Completed on 2025-04-11 20:35:29

--
-- PostgreSQL database dump complete
--

