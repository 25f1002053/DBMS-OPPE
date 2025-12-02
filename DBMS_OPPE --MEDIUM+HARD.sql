/*
1. Find department_code in which total number of female students is less than 7
*/

SELECT
	department_code
FROM
	students
WHERE
	gender = 'F'
GROUP BY department_code
HAVING COUNT(*)<7;

/*
2. Find name and dob of oldest player
*/

SELECT
	name,
	dob
FROM
	players
ORDER BY dob
LIMIT 1;

/*
3. Find user_name and order_id of all such order whose payment amount is greater than payment amount for all orders placed on '2022-04-08'
*/

SELECT
	user_name,
	o.order_id
FROM
	orders o
JOIN payment p ON p.order_id = o.order_id
JOIN users u ON u.user_id = o.user_id
WHERE
	amount > (SELECT 
					sum(amount)
				FROM
					payment p
				JOIN orders o ON o.order_id = p.order_id
				WHERE 
                    o.date_ordered = '2022-04-08');

/*
4. Write an SQL Query to find the names of the products along with their average rating which have an average rating of at least 4
*/

SELECT
	product_name,
	AVG(rating) AS average_rating
FROM
	reviews r
JOIN product p ON p.product_id = r.product_id
GROUP BY product_name
HAVING AVG(rating)>=4;

/*
5. Write an SQL Query to find name of the players who do not belong to the team name 'Amigos'
*/

SELECT
	p.name
FROM
	players p
JOIN teams t ON t.team_id = p.team_id
WHERE 
    t.name <> 'Amigos';

/*
6. Write an SQL Query to find the department code of the departments in which total number of male students is less than 7
*/

SELECT
	department_code
FROM
	students
WHERE
	gender = 'M'
GROUP BY department_code
HAVING COUNT(*) < 7;

/*
7. write a SQL query to find the name of the products with their average ratings which have an average rating greater than 3
*/

SELECT
	product_name,
	AVG(rating) AS average_rating
FROM
	reviews r
JOIN product p ON p.product_id = r.product_id
GROUP BY product_name
HAVING AVG(rating)>3;

/*
8. Write a SQL query to find the name of the product ordered by user 'EVIE' on 2023-11-05'
*/

SELECT
	product_name
FROM
	orders o
JOIN product p ON p.product_id = o.product_id
JOIN users u ON u.user_id = o.user_id
WHERE
	u.user_name = 'EVIE' AND
	date_ordered = '2023-11-05';

/*
9. Write a SQL query to find the name of referees who were the fourth refereefor match numbers 'M0001', 'M0003', 'M0005'
*/

SELECT
	name
FROM
	match_referees mr
JOIN referees r ON r.referee_id = mr.fourth_referee
WHERE
	match_num IN ('M0001', 'M0003', 'M0005');

/*
10. Write an SQL query to retrieve the names of all teams that have won all the matches they played (means their score was always higher than the guest
team)
*/

SELECT
	name
FROM
	teams t
WHERE
	NOT EXISTS (SELECT
					*
				FROM
					matches m
				WHERE
					m.host_team_id = t.team_id AND
					m.host_team_score <= m.guest_team_score);

/*
11. Write an SQL to find the id of users who have written a review for a product in the 'Electronics' category but have never reviewed any product from the 'Clothing' category
*/

SELECT
	user_id
FROM
	reviews r
JOIN product p ON p.product_id = r.product_id
JOIN categories c ON c.category_id = p.category_id
WHERE
	c.category_name = 'Electronics'
EXCEPT
SELECT
	user_id
FROM
	reviews r
JOIN product p ON p.product_id = r.product_id
JOIN categories c ON c.category_id = p.category_id
WHERE
	c.category_name = 'Clothing';

/*
12. Write a SQL statement to find the player name, jersey no of player and team name of players who played for teams that hosted matches in 2020 and also had a jersey number less than 10
*/

SELECT DISTINCT
	p.name,
	jersey_no,
	t.name
FROM
	matches m
JOIN teams t ON t.team_id = m.host_team_id
JOIN players p ON p.team_id = t.team_id
WHERE
	match_date BETWEEN '2020-01-01' AND '2020-12-31' AND
	jersey_no < 10;

/*
13. Write an SQL query to find the players’ name, jersey number and team name of players whose jersey number is less than the average jersey number of their team
*/

SELECT
	p1.name,
	jersey_no,
	t.name
FROM
	players p1
JOIN teams t ON t.team_id = p1.team_id
WHERE
	jersey_no < (
		SELECT
			AVG(jersey_no)
		FROM
			players p2
		WHERE
			team_id = p1.team_id
	);

/*
14. Write an SQL query to find the total number of books available in the library for publishers NCERT, Wiley, and Pearson Education. Display Publisher name along with total books
*/

SELECT
	publisher,
	count(*)
FROM
	book_copies bc
JOIN book_catalogue b ON b.isbn_no = bc.isbn_no
WHERE
	publisher IN ('NCERT', 'Wiley', 'Pearson Education')
GROUP BY publisher;

/*
15. Write an SQL query to find the names of users who have placed orders for products in the ‘Electronics’ category
*/

SELECT
	user_name
FROM
	users u
WHERE
	EXISTS (
		SELECT
			*
		FROM
			orders o
		JOIN product p ON o.product_id = o.product_id
		JOIN categories c ON c.category_id = p.category_id
		WHERE
			o.user_id = u.user_id AND
			c.category_name = 'Electronics'
	);

-- 5 mark problems

/*
1. Find title and doi of books issued by students whose first_name ends with 'a' and from department 'Mechanical Engineering' or 'Computer Science'
*/

SELECT DISTINCT
	title,
	doi
FROM
	book_issue bi
JOIN book_copies bc ON bc.accession_no = bi.accession_no
JOIN book_catalogue b ON b.isbn_no = bc.isbn_no
JOIN members m ON m.member_no = bi.member_no AND m.member_class = 'Student'
JOIN students s ON s.roll_no = m.roll_no
JOIN departments d ON d.department_code = s.department_code
WHERE
	department_name IN ('Mechanical Engineering', 'Computer Science') AND
	student_fname LIKE '%a';

/*
2. Write an SQL Query to find name and dob of the assistant_referee_2 of the match between 'all Star' and 'Amigos' on '2020-05-17'
*/

SELECT
	r.name,
	dob
FROM
	referees r
JOIN match_referees mr ON mr.assistant_referee_2 = r.referee_id
JOIN matches m ON m.match_num = mr.match_num
JOIN teams t1 ON t1.team_id = m.host_team_id
JOIN teams t2 ON t2.team_id = m.guest_team_id
WHERE
	match_date = '2020-05-17' AND
	(t1.name = 'All Stars' AND t2.name = 'Amigos') OR
	(t1.name = 'Amigos' AND t2.name = 'All Stars');

/*
3. Write a SQL query to find the title, date of issue (doi) of the books issued by the students whose first name starts with 'S' and from departments 'Mechanical Engineering' or Computer Science'
*/

SELECT DISTINCT
	title,
	doi
FROM
	book_issue bi
JOIN book_copies bc ON bc.accession_no = bi.accession_no
JOIN book_catalogue b ON b.isbn_no = bc.isbn_no
JOIN members m ON m.member_no = bi.member_no
JOIN students s ON s.roll_no = m.roll_no
JOIN departments d ON d.department_code = s.department_code
WHERE
	department_name IN ('Mechanical Engineering', 'Computer Science') AND
	student_fname LIKE 'S%';

/*
4. Write an SQL query to find the team names that have never lost a match (as a host or as a guest)
*/

SELECT
	name
FROM
	teams t
WHERE
	NOT EXISTS (
		SELECT
			*
		FROM
			matches m
		WHERE
			host_team_id = t.team_id AND
			host_team_score < guest_team_score
	) AND
	NOT EXISTS (
		SELECT
			*
		FROM
			matches m
		WHERE
			guest_team_id = t.team_id AND
			guest_team_score < host_team_score
	);

/*
5. Write a SQL statement to find the player name, jersey no of player and team name of players who played for teams that hosted matches in 2020 and also had a jersey number less than 10
*/

SELECT DISTINCT
	p.name,
	jersey_no,
	t.name
FROM
	players p
JOIN teams t ON p.team_id = t.team_id
JOIN matches m ON m.host_team_id = t.team_id
WHERE
	match_date BETWEEN '2020-01-01' AND '2020-12-31' AND
	jersey_no < 10;
