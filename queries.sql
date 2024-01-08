CREATE MATERIALIZED VIEW monthly_lesson AS
SELECT 
    EXTRACT(YEAR FROM date) AS Year,
    TO_CHAR(date, 'Month') AS month,
    EXTRACT(MONTH FROM date) AS month_number,
    (COUNT(DISTINCT individual_lesson.lesson_id) + COUNT(DISTINCT group_lesson.lesson_id) + COUNT(DISTINCT ensemble.lesson_id)) AS Total,
    COUNT(DISTINCT individual_lesson.lesson_id) AS individual_lesson,
    COUNT(DISTINCT group_lesson.lesson_id) AS group_lesson,
    COUNT(DISTINCT ensemble.lesson_id) AS ensemble
FROM 
    lesson
    LEFT JOIN individual_lesson ON lesson.lesson_id = individual_lesson.lesson_id
    LEFT JOIN group_lesson ON lesson.lesson_id = group_lesson.lesson_id
    LEFT JOIN ensemble ON lesson.lesson_id = ensemble.lesson_id
WHERE 
    EXTRACT(YEAR FROM date) = 2023 -- Change year here
GROUP BY 
    Year, month, month_number
ORDER BY 
    Year, month_number;


	
-- How many students there are with no sibling, with one sibling, with two siblings, etc. 
CREATE MATERIALIZED VIEW student_sibling_table AS
SELECT
    COALESCE(ss.sibling_count, 0) AS "No of Siblings",
    COUNT(*) AS "No of Students"
FROM
    (SELECT student_id FROM student) s
LEFT JOIN
    (SELECT student_id, COUNT(*) AS sibling_count FROM student_siblings GROUP BY student_id) ss
ON s.student_id = ss.student_id
GROUP BY "No of Siblings"
ORDER BY "No of Siblings";



-- List ids and names of all instructors who has given more than a specific number of lessons during the current month.
CREATE VIEW instructor_overwork AS
SELECT
  ins.instructor_id,
  per.first_name,
  per.last_name,
  COUNT(*) AS "No of Lessons"
FROM
  instructor ins
JOIN
  person per ON ins.person_id = per.person_id
JOIN
  lesson l ON ins.instructor_id = l.instructor_id
WHERE
  l.date >= DATE_TRUNC('month', CURRENT_DATE)
  AND l.date < DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month'
GROUP BY
  ins.instructor_id, per.first_name, per.last_name
HAVING
  COUNT(*) > 2 -- Here we write the maximum number of lessons 
ORDER BY
  "No of Lessons" DESC;


-- List all ensembles held during the next week
CREATE VIEW ensemble_availability AS
SELECT
  TO_CHAR(l.date, 'Dy') AS "Day",
  e.genre AS "Genre",
  CASE
    WHEN e.maximum_students - COALESCE(se.enrolled, 0) <= 0 THEN 'No Seats'
    WHEN e.maximum_students - COALESCE(se.enrolled, 0) BETWEEN 1 AND 2 THEN '1 or 2 Seats'
    ELSE 'Many Seats'
  END AS "No of Free Seats"
FROM
  lesson l
JOIN
  ensemble e ON l.lesson_id = e.lesson_id
LEFT JOIN
  (SELECT
     lesson_id,
     COUNT(*) AS enrolled
   FROM
     ensemble
   GROUP BY
     lesson_id) se ON e.lesson_id = se.lesson_id
GROUP BY
  l.date,
  e.genre,
  e.maximum_students,
  se.enrolled
ORDER BY
  l.date, 
  TO_CHAR(l.date, 'D');

