SELECT * FROM hw_for_lesson2.staff;
SELECT * FROM staff;
UPDATE staff
SET post = 'Рабочий'
WHERE id = 11;
SELECT * FROM staff;

SELECT * FROM staff;

SELECT * FROM staff
ORDER BY salary;

SELECT * FROM staff
ORDER BY salary DESC;

SELECT * FROM staff
ORDER BY salary DESC 
LIMIT 5;

SELECT post, SUM(salary) AS sum_salary
FROM staff
GROUP BY post;

SELECT firstname, lastname, post, age
FROM staff 
WHERE post = 'Рабочий' AND age BETWEEN 24 AND 49;

SELECT COUNT(DISTINCT post) as total_post
FROM staff;

SELECT post
FROM staff 
WHERE age = ( SELECT AVG(age) < 30 FROM staff);
-- таких значений нет


