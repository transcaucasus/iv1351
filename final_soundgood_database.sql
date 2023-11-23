CREATE TABLE address (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 street VARCHAR(500) NOT NULL,
 city VARCHAR(500) NOT NULL,
 zip VARCHAR(5) NOT NULL
);

ALTER TABLE address ADD CONSTRAINT PK_address PRIMARY KEY (id);


CREATE TABLE instrument (
 instrument_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 name  VARCHAR(500) NOT NULL,
 type  VARCHAR(500) NOT NULL,
 price  VARCHAR(500) NOT NULL,
 is_rented BOOLEAN NOT NULL,
 quantity_in_stock INT
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (instrument_id);


CREATE TABLE person (
 person_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 address_id INT NOT NULL,
 social_security_number VARCHAR(12) NOT NULL,
 first_name VARCHAR(100) NOT NULL,
 last_name VARCHAR(100) NOT NULL,
 phone_no VARCHAR(10),
 email VARCHAR(500)
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (person_id);


CREATE TABLE pricing_scheme (
 pricing_scheme_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 type VARCHAR(100) NOT NULL,
 level VARCHAR(100) NOT NULL,
 price DOUBLE PRECISION NOT NULL,
 sibling_discount DECIMAL(10)
);

ALTER TABLE pricing_scheme ADD CONSTRAINT PK_pricing_scheme PRIMARY KEY (pricing_scheme_id);


CREATE TABLE student (
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 person_id INT NOT NULL,
 instrument_id_1 INT NOT NULL,
 instrument_id_2 INT NOT NULL,
 has_sibling BOOLEAN NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE student_siblings (
 student_id INT NOT NULL,
 sibling_id INT NOT NULL
);

ALTER TABLE student_siblings ADD CONSTRAINT PK_student_siblings PRIMARY KEY (student_id,sibling_id);


CREATE TABLE instructor (
 instructor_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_id);


CREATE TABLE instructor_availability (
 instructor_id INT NOT NULL,
 weekday VARCHAR(10),
 start_time TIMESTAMP(10),
 end_time TIMESTAMP(10),
 is_available BOOLEAN
);


CREATE TABLE instructor_instruments (
 instructor_id INT NOT NULL,
 instrument_id INT NOT NULL
);

ALTER TABLE instructor_instruments ADD CONSTRAINT PK_instructor_instruments PRIMARY KEY (instructor_id,instrument_id);


CREATE TABLE instrument_rental (
 instrument_rental_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument_id INT NOT NULL,
 student_id INT NOT NULL,
 start_date DATE,
 end_date DATE,
 is_returned BOOLEAN NOT NULL
);

ALTER TABLE instrument_rental ADD CONSTRAINT PK_instrument_rental PRIMARY KEY (instrument_rental_id,instrument_id,student_id);


CREATE TABLE lesson (
 lesson_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 pricing_scheme_id INT NOT NULL,
 instructor_id INT NOT NULL,
 instrument VARCHAR(100) NOT NULL,
 time  TIMESTAMP(10) NOT NULL,
 date  DATE NOT NULL,
 location  VARCHAR(100) NOT NULL,
 level VARCHAR(100) NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (lesson_id);


CREATE TABLE parent_contact_info (
 student_id INT NOT NULL,
 parent_firstname VARCHAR(100),
 parent_lastname VARCHAR(100),
 phone_no VARCHAR(10)
);


CREATE TABLE student_lesson (
 student_id INT NOT NULL,
 lesson_id INT NOT NULL
);

ALTER TABLE student_lesson ADD CONSTRAINT PK_student_lesson PRIMARY KEY (student_id,lesson_id);


CREATE TABLE ensemble (
 ensemble_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 lesson_id INT NOT NULL,
 maximum_students INT,
 minimum_students INT,
 genre VARCHAR(100)
);

ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (ensemble_id,lesson_id);


CREATE TABLE group_lesson (
 group_lesson_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 lesson_id INT NOT NULL,
 maximum_students INT,
 minimum_students INT
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (group_lesson_id,lesson_id);


CREATE TABLE individual_lesson (
 individual_lesson_id  INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 lesson_id INT NOT NULL
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (individual_lesson_id ,lesson_id);


ALTER TABLE person ADD CONSTRAINT FK_person_0 FOREIGN KEY (address_id) REFERENCES address (id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (person_id);
ALTER TABLE student ADD CONSTRAINT FK_student_1 FOREIGN KEY (instrument_id_1) REFERENCES instrument (instrument_id);
ALTER TABLE student ADD CONSTRAINT FK_student_2 FOREIGN KEY (instrument_id_2) REFERENCES instrument (instrument_id);


ALTER TABLE student_siblings ADD CONSTRAINT FK_student_siblings_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE student_siblings ADD CONSTRAINT FK_student_siblings_1 FOREIGN KEY (sibling_id) REFERENCES student (student_id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE instructor_availability ADD CONSTRAINT FK_instructor_availability_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


ALTER TABLE instructor_instruments ADD CONSTRAINT FK_instructor_instruments_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE instructor_instruments ADD CONSTRAINT FK_instructor_instruments_1 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);


ALTER TABLE instrument_rental ADD CONSTRAINT FK_instrument_rental_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);
ALTER TABLE instrument_rental ADD CONSTRAINT FK_instrument_rental_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (pricing_scheme_id) REFERENCES pricing_scheme (pricing_scheme_id);
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


ALTER TABLE parent_contact_info ADD CONSTRAINT FK_parent_contact_info_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_1 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);


ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);


