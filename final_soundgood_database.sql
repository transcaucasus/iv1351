CREATE SEQUENCE address_id_seq START WITH 1;
CREATE TABLE address (
 id INT GENERATED ALWAYS AS IDENTITY (START WITH 1) NOT NULL,
 street VARCHAR(500) NOT NULL,
 city VARCHAR(500) NOT NULL,
 zip VARCHAR(5) NOT NULL,
 PRIMARY KEY (id)
);

CREATE TABLE person (
    person_id INT GENERATED ALWAYS AS IDENTITY (START WITH 1) NOT NULL,
    address_id INT NOT NULL,
    social_security_number VARCHAR(12) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_no VARCHAR(10),
    email VARCHAR(500),
    PRIMARY KEY (person_id)
);

CREATE TABLE pricing_scheme (
    pricing_scheme_id INT GENERATED ALWAYS AS IDENTITY (START WITH 1) NOT NULL,
    lesson_type VARCHAR(100) NOT NULL,
    lesson_level VARCHAR(100) NOT NULL,
    price DOUBLE PRECISION NOT NULL,
    sibling_discount DECIMAL(10,2),  
    PRIMARY KEY (pricing_scheme_id)
);

CREATE TABLE instrument_details (
    instrument_detail_id INT GENERATED ALWAYS AS IDENTITY (START WITH 1) NOT NULL,
    name VARCHAR(500) NOT NULL,
    price VARCHAR(500) NOT NULL, 
    type VARCHAR(500) NOT NULL,
    PRIMARY KEY (instrument_detail_id)
);

CREATE TABLE instrument (
    instrument_id INT GENERATED ALWAYS AS IDENTITY (START WITH 1) NOT NULL,
    instrument_detail_id INT NOT NULL,
    PRIMARY KEY (instrument_id),
    FOREIGN KEY (instrument_detail_id) REFERENCES instrument_details(instrument_detail_id)
);





CREATE TABLE student (
 student_id INT GENERATED ALWAYS AS IDENTITY (START WITH 1) NOT NULL,
 person_id INT NOT NULL,
 instrument_id_1 INT,
 instrument_id_2 INT,
 PRIMARY KEY (student_id),
 FOREIGN KEY (person_id) REFERENCES person(person_id),
 FOREIGN KEY (instrument_id_1) REFERENCES instrument(instrument_id),
 FOREIGN KEY (instrument_id_2) REFERENCES instrument(instrument_id)
);

CREATE TABLE student_siblings (
 student_id INT NOT NULL,
 sibling_id INT NOT NULL,
 PRIMARY KEY (student_id, sibling_id),
 FOREIGN KEY (student_id) REFERENCES student(student_id),
 FOREIGN KEY (sibling_id) REFERENCES student(student_id)
);




CREATE TABLE instructor (
    instructor_id INT GENERATED ALWAYS AS IDENTITY (START WITH 1) NOT NULL,
    person_id INT NOT NULL,
    PRIMARY KEY (instructor_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id)
);


CREATE TABLE instructor_availability (
    instructor_id INT NOT NULL,
    weekday VARCHAR(10) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    is_available BOOLEAN NOT NULL,
    PRIMARY KEY (instructor_id, weekday, start_time), 
    FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id)
);



CREATE TABLE instructor_instruments (
    instructor_id INT NOT NULL,
    instrument_id INT NOT NULL,
    PRIMARY KEY (instructor_id, instrument_id),
    FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id),
    FOREIGN KEY (instrument_id) REFERENCES instrument(instrument_id)
);



CREATE TABLE instrument_rental (
    instrument_rental_id INT GENERATED ALWAYS AS IDENTITY (START WITH 1) NOT NULL,
    instrument_id INT NOT NULL,
    student_id INT,
    start_date DATE,
    end_date DATE,
    is_returned BOOLEAN NOT NULL,
    PRIMARY KEY (instrument_rental_id),
    FOREIGN KEY (instrument_id) REFERENCES instrument(instrument_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);



CREATE TABLE lesson (
    lesson_id INT GENERATED ALWAYS AS IDENTITY (START WITH 1) NOT NULL,
    pricing_scheme_id INT NOT NULL,
    instructor_id INT NOT NULL,
    time TIMESTAMP NOT NULL,
    date DATE NOT NULL,
    location VARCHAR(100) NOT NULL,
    PRIMARY KEY (lesson_id),
    FOREIGN KEY (pricing_scheme_id) REFERENCES pricing_scheme(pricing_scheme_id),
    FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id)
);



CREATE TABLE parent_contact_info (
    parent_first_name VARCHAR(100),
    parent_last_name VARCHAR(100),
    phone_no VARCHAR(10),
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);


CREATE TABLE student_lesson (
    lesson_id INT NOT NULL,
    student_id INT NOT NULL,
    PRIMARY KEY (lesson_id, student_id),
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);



CREATE TABLE ensemble (
    ensemble_id INT GENERATED ALWAYS AS IDENTITY (START WITH 1) NOT NULL,
    lesson_id INT NOT NULL,
    maximum_students INT,
    minimum_students INT,
    genre VARCHAR(100) NOT NULL,
    instrument VARCHAR(100) NOT NULL,
    PRIMARY KEY (ensemble_id),
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id)
);



CREATE TABLE group_lesson (
    group_lesson_id INT GENERATED ALWAYS AS IDENTITY (START WITH 1) NOT NULL,
    lesson_id INT NOT NULL,
    maximum_students INT,
    minimum_students INT,
    PRIMARY KEY (group_lesson_id),
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id)
);



CREATE TABLE individual_lesson (
    individual_lesson_id INT GENERATED ALWAYS AS IDENTITY (START WITH 1) NOT NULL,
    lesson_id INT NOT NULL,
    instrument VARCHAR(100) NOT NULL,
    PRIMARY KEY (individual_lesson_id),
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id)    
);






