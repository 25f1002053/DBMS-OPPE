/*
1. Write an SQL query to find the titles and publishers of books where the title contains 
the word Python. Display title and publisher name
*/

SELECT
	title,
	publisher
FROM
	book_catalogue
WHERE
	title LIKE '%Python%';

/*
2. Write an SQL query to find the name of the host team that played a match on '2020-05-15'
*/

SELECT
	name
FROM
	matches m
JOIN teams t ON t.team_id = m.host_team_id
WHERE
	match_date = '2020-05-15';

/*
3. Write an SQL query to find the product name whose price is higher than the average price of all products. Display product_name and price
*/

SELECT
	product_name
FROM
	product
WHERE
	price > (
		SELECT
			AVG(price)
		FROM
			product
	);

/*
4. Write an SQL query to find the players name, jersey number and team name of players whose jersey number is greater than the average jersey number of their team
*/

SELECT
	p1.name,
	jersey_no,
	t.name
FROM
	players p1
JOIN teams t ON t.team_id = p1.team_id
WHERE
	jersey_no > (
		SELECT
			AVG(jersey_no)
		FROM
			players p2
		WHERE
			p2.team_id = p1.team_id
	);

/*
5. Write an SQL query to find the total number of books available in the library for publishers NCERT, Wiley, and CareerCup. Display Publisher name along with total books. (Hint: number of books means number of copies.)
*/

SELECT
	publisher,
	count(*)
FROM
	book_copies bc
JOIN
	book_catalogue b ON b.isbn_no = bc.isbn_no
WHERE
	publisher IN ('NCERT', 'Wiley', 'CareerCup')
GROUP BY publisher;

/*
6. Write an SQL query to find the names of users who have placed orders for products in the 'Footwear' category
*/

SELECT
	u.user_name
FROM
	users u
WHERE
	EXISTS (
		SELECT
			*
		FROM
			orders o
		JOIN product p ON p.product_id = o.product_id
		JOIN categories c ON c.category_id = p.category_id
		WHERE
			o.user_id = u.user_id AND
			category_name = 'Footwear'
	);

/*
7. Write an SQL query to find the team names that have never lost a match (as a host or as a guest)
*/

SELECT DISTINCT
	t1.name
FROM 
	teams t1
WHERE
	NOT EXISTS (
		SELECT
			*
		FROM
			matches
		WHERE
			host_team_id = t1.team_id AND
			host_team_score < guest_team_score
	)
INTERSECT
SELECT DISTINCT
	t1.name
FROM 
	teams t1
WHERE
	NOT EXISTS (
		SELECT
			*
		FROM
			matches
		WHERE
			guest_team_id = t1.team_id AND
			guest_team_score < host_team_score
	);