SELECT * FROM lesson_4.likes;
-- 1
SELECT 
COUNT(*) AS "Total likes"
FROM likes
WHERE user_id IN (
SELECT user_id
FROM profiles
WHERE timestampdiff(Year, birthday, NOW()) < 12);

SELECT * FROM profiles
WHERE timestampdiff(Year, birthday, NOW()) < 12;

-- 2

SELECT CASE (gender)
WHEN 'm' THEN 'male'
WHEN 'f' THEN 'female'
END AS ' More LIKES marked by:', COUNT(*) AS 'likes total'
FROM profiles pro
JOIN likes l
WHERE l.user_id = pro.user_id
GROUP BY gender
LIMIT 2;

-- 3
SELECT distinct CONCAT (firstname, ' ', lastname, ' (id: ', (id), ')') AS 'No msg'
FROM users
WHERE NOT EXISTS (
SELECT from_user_id
FROM messages
WHERE users.id = messages.from_user_id);

-- 4

SELECT from_user_id AS 'sender id', 
	(SELECT CONCAT(firstname,' ', lastname) 
    FROM users 
    WHERE id = messages.from_user_id) AS 'Sender name', COUNT(*) AS `Msg sent`
FROM messages 
WHERE to_user_id = 1 AND from_user_id IN (
	SELECT initiator_user_id 
    FROM friend_requests 
    WHERE (target_user_id = 1) AND status ='approved'
    UNION
    SELECT target_user_id 
    FROM friend_requests 
    WHERE (initiator_user_id = 1) AND status ='approved' 
)
GROUP BY from_user_id
ORDER BY `Msg sent` DESC 
LIMIT 1;