/*
1. Find the name of team whose jersey_home_color is Red
*/

SELECT
	name
FROM
	teams
WHERE
	jersey_home_color = 'Red';

/*
2. Find the name of host_team that played match on '2020-05-22'
*/

SELECT
	name
FROM
	teams t
JOIN matches m ON m.host_team_id = t.team_id
WHERE
	match_date = '2020-05-22';

/*
3. Find first_name and member_no of all such students whose roll_no ends with '03'
*/

SELECT
	student_fname,
	member_no
FROM
	students s
JOIN members m ON m.roll_no = s.roll_no AND m.member_class = 'Student'
WHERE
	s.roll_no LIKE '%03';

/*
4. Write an SQL Query to find all the usernames from state "Rajasthan"
*/

SELECT
	user_name
FROM
	users u
JOIN address a ON a.user_id = u.user_id
WHERE
	a.state = 'Rajasthan';

/*
5. Write an SQL Query to find name of all the players whose name ends with 'm' and has atleast 5 character
*/

SELECT
	name
FROM
	players
WHERE
	name LIKE '%____m';

/*
6. Write an SQL Query to find name of managers of the team 'Black Eagles'
*/

SELECT
	m.name
FROM
	managers m
JOIN teams t ON t.team_id = m.team_id
WHERE
	t.name = 'Black Eagles';

/*
7. Write a SQL query to find the host team id and the guest team id of the matches played before MAY 15, 2020, in which the host team scored more than 2 goals.
*/

SELECT
	host_team_id,
	guest_team_id
FROM
	matches
WHERE
	match_date < '2020-05-15' AND
	host_team_score > 2;

/*
8. Write a SQL query to find the name of the managers whose names contain at least six characters
*/

SELECT
	name
FROM
	managers
WHERE
	name LIKE '______%';

/*
9. Write a SQL query to find the member type and member number of the female students who are from the department code 'EE'
*/

SELECT
	member_type,
	member_no
FROM
	members m
JOIN students s ON s.roll_no = m.roll_no AND m.member_class = 'Student'
WHERE
	s.department_code = 'EE' AND
	s.gender = 'F';

/*
10. Write an SQL query to find the name and quantity of the products whose name ends with the character 'b' and contains at least five characters
*/

SELECT
	product_name,
	quantity
FROM
	product
WHERE
	product_name LIKE '%____b';

/*
11. Write an SQL query to find the titles of the book, that were published after 2005 and author's first name is 'Subrata' and lastname is 'Saha'
*/

SELECT
	title
FROM
	book_catalogue bc
JOIN book_authors ba ON ba.isbn_no = bc.isbn_no
WHERE
	year > 2005 AND
	author_fname = 'Subrata' AND
	author_lname = 'Saha';

/*
12. Write an SQL query to find the referee_id, number of matches conducted by referee 'Tony Joseph Louis'
*/

SELECT
	referee,
	count(*)
FROM
	match_referees mr
JOIN referees r ON r.referee_id = mr.referee
WHERE
	name = 'Tony Joseph Louis'
GROUP BY referee;

/*
13. Write an SQL query to find the titles and publishers of books where the title contains the word ‘Python’. Display title and publisher name
*/

SELECT
	title,
	publisher
FROM
	book_catalogue
WHERE
	title LIKE '%Python%';

/*
14. Write an SQL query to find the name of the host team that played a match on '2020-05-15'
*/

SELECT
	name
FROM
	matches m
JOIN teams t ON t.team_id = m.host_team_id
WHERE
	match_date = '2020-05-15';

/*
15. Write an SQL query to find the names of users who have never placed an order
*/

SELECT
	user_name
FROM
	users u
WHERE
	NOT EXISTS (
		SELECT
			*
		FROM
			orders o
		WHERE
			o.user_id = u.user_id
	);