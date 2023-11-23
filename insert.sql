INSERT INTO address (street, city, zip) VALUES
('123 Maple Street', 'Springfield', '12345'),
('234 Oak Avenue', 'Greenville', '23456'),
('345 Pine Lane', 'Franklin', '34567'),
('456 Birch Drive', 'Bristol', '45678'),
('567 Cedar Blvd', 'Clinton', '56789'),
('678 Elm Street', 'Fairview', '67890'),
('789 Walnut Avenue', 'Salem', '78901');

INSERT INTO person (address_id, social_security_number, first_name, last_name, phone_no, email) VALUES
(1, '123-45-6789', 'John', 'Doe', '555-0101', 'john.doe@example.com'),
(2, '234-56-7890', 'Jane', 'Smith', '555-0102', 'jane.smith@example.com'),
(3, '345-67-8901', 'James', 'Johnson', '555-0103', 'james.johnson@example.com'),
(4, '456-78-9012', 'Emily', 'Johnson', '555-0104', 'emily. johnson @example.com'),
(5, '567-89-0123', 'Michael', 'Brown', '555-0105', 'michael.brown@example.com'),
(6, '678-90-1234', 'Jessica', 'Taylor', '555-0106', 'jessica.taylor@example.com'),
(7, '789-01-2345', 'William', 'Anderson', '555-0107', 'william.anderson@example.com');

INSERT INTO instrument (name, type, price, is_rented, quantity_in_stock) VALUES
('Yamaha C40', 'Acoustic Guitar', '140.00', FALSE, 10),
('Fender Stratocaster', 'Electric Guitar', '700.00', FALSE, 5),
('Steinway Model D', 'Grand Piano', '15800.00', TRUE, 2),
('Korg Minilogue', 'Synthesizer', '500.00', FALSE, 4),
('Pearl Roadshow', 'Drum Kit', '650.00', TRUE, 3),
('Mendini by Cecilio', 'Violin', '120.00', FALSE, 8),
('Jean Paul USA TR-430', 'Trumpet', '250.00', FALSE, 6);

INSERT INTO student (person_id, instrument_id_1, instrument_id_2, has_sibling) VALUES
(1, 1, 2, FALSE),
(2, 2, 3, FALSE),
(3, 3, 4, TRUE),
(4, 4, 5, TRUE);

INSERT INTO instrument_rental (instrument_id, student_id, start_date, end_date, is_returned) VALUES
(6, 4, '2023-07-17', '2023-10-03', FALSE),
(1, 3, '2023-08-04', '2023-12-05', TRUE),
(3, 3, '2023-01-21', '2023-04-23', TRUE),
(4, 2, '2023-05-13', '2023-10-10', FALSE),
(5, 2, '2023-09-19', '2023-11-14', TRUE),
(7, 1, '2023-09-06', '2024-01-14', FALSE),
(2, 1, '2023-07-27', '2023-09-01', TRUE);

INSERT INTO instructor (person_id) VALUES
(5),
(6),
(7);
INSERT INTO instructor_availability (instructor_id, weekday, start_time, end_time, is_available) VALUES
(1, 'Monday', '2023-01-01 08:00:00', '2023-01-01 10:00:00', TRUE),
(2, 'Tuesday', '2023-01-02 09:00:00', '2023-01-02 11:00:00', FALSE),
(3, 'Wednesday', '2023-01-03 10:00:00', '2023-01-03 12:00:00', TRUE);

INSERT INTO instructor_instruments (instructor_id, instrument_id) VALUES
(1, 7),
(2, 4),
(3, 3);

INSERT INTO student_siblings (student_id, sibling_id) VALUES
(3, 4),
(3, 3);

INSERT INTO parent_contact_info (student_id, parent_firstname, parent_lastname, phone_no) VALUES
(1, 'Sarah', 'Doe', '555-0204'),
(2, 'David', 'Smith', '555-0205'),
(3, 'Angela', 'Johnson', '555-0206'),
(1, 'Mark', 'Davis', '555-0207'),
(4, 'Angela', 'Johnson', '555-0206');

INSERT INTO pricing_scheme (type, level, price, sibling_discount) VALUES
('Individual Lesson', 'Beginner', 30.0, 0.1),
('Group Lesson', 'Intermediate', 20.0, 0.15),
('Ensemble', 'Advanced', 15.0, 0.1),
('Individual Lesson', 'Intermediate', 35.0, 0.2),
('Group Lesson', 'Advanced', 25.0, 0.15),
('Ensemble', 'Beginner', 18.0, 0.1),
('Individual Lesson', 'Advanced', 40.0, 0.25);

INSERT INTO lesson (pricing_scheme_id, instructor_id, instrument, time, date, location, level) VALUES
(7, 2, 'Cello', '2023-11-23 15:33:46', '2023-12-22', 'Room 201', 'Beginner'),
(3, 3, 'Drums', '2023-11-23 15:33:46', '2023-12-06', 'Room 204', 'Intermediate'),
(4, 2, 'Trumpet', '2023-11-23 15:33:46', '2023-12-22', 'Room 102', 'Advanced'),
(2, 2, 'Guitar', '2023-11-23 15:33:46', '2023-12-18', 'Room 101', 'Advanced'),
(7, 2, 'Trumpet', '2023-11-23 15:33:46', '2023-12-16', 'Room 204', 'Advanced'),
(2, 2, 'Piano', '2023-11-23 15:33:46', '2023-12-17', 'Room 101', 'Advanced'),
(3, 2, 'Trumpet', '2023-11-23 15:33:46', '2023-11-27', 'Room 103', 'Intermediate');

INSERT INTO individual_lesson (lesson_id) VALUES
(1),
(2);


INSERT INTO group_lesson (lesson_id, maximum_students, minimum_students) VALUES
(3, 8, 4),
(4, 5, 3),
(5, 9, 4);


INSERT INTO ensemble (lesson_id, maximum_students, minimum_students, genre) VALUES
(6, 11, 4, 'Classical'),
(7, 9, 4, 'Blues'),
(7, 9, 4, 'Rock');


INSERT INTO student_lesson (student_id, lesson_id) VALUES
(4, 5),
(2, 4),
(1, 6),
(3, 3);
