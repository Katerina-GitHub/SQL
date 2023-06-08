SELECT * FROM lesson_4.users;

/*1. Создайте представление, в которое попадет информация о пользователях (имя, фамилия,
город и пол), которые не старше 20 лет.*/

CREATE OR REPLACE VIEW v_young_users AS
SELECT 
CONCAT(firstname, ' ', lastname) AS name,
hometown, gender
FROM lesson_4.users
JOIN lesson_4.profiles ON users.id = profiles.user_id
WHERE TIMESTAMPDIFF (YEAR,birthday,NOW()) < 20
GROUP BY users.id;

SELECT * FROM v_young_users;

/* 2. Найдите кол-во, отправленных сообщений каждым пользователем и выведите
ранжированный список пользователей, указав имя и фамилию пользователя, количество
отправленных сообщений и место в рейтинге (первое место у пользователя с максимальным
количеством сообщений) . (используйте DENSE_RANK)*/

SELECT 
	DENSE_RANK() OVER (ORDER BY COUNT(from_user_id) DESC) AS 'Top Rating',
	COUNT(from_user_id) AS 'msg sent',
	CONCAT(firstname, ' ', lastname) AS 'name'
FROM lesson_4.users
JOIN lesson_4.messages ON  users.id = messages.from_user_id
GROUP BY users.id
;

/*3. Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления
(created_at) и найдите разницу дат отправления между соседними сообщениями,
получившегося списка. (используйте LEAD или LAG)*/

SELECT *, 
LAG(created_at) OVER 
(PARTITION BY TIMESTAMPDIFF(SECOND, created_at, created_at)) 
AS LAG_created, 
LEAD(created_at) OVER 
(PARTITION BY TIMESTAMPDIFF(SECOND, created_at, created_at)) 
AS LEAD_created
FROM messages 
ORDER BY TIMESTAMPDIFF(SECOND, created_at, NOW()) DESC;

