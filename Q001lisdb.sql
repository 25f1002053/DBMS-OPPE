/*
Write an SQL statement to find the number of book-titles issues on 11th August 2021
*/

SELECT
	count(DISTINCT title)
FROM
	book_catalogue b
JOIN book_copies bc ON bc.ISBN_no = b.ISBN_no
JOIN book_issue bi ON bi.accession_no = bc.accession_no
WHERE
	doi = '2021-08-11';

/*
Write a SQL statement to find the names of faculty (faculty_fname, faculty_lname) who did not issue any book
*/

SELECT
	faculty_fname,
	faculty_lname
FROM
	faculty f
WHERE
	NOT EXISTS(
		SELECT
			*
		FROM
			book_issue bi
		JOIN members m ON m.member_no = bi.member_no
		WHERE 
			m.member_class = 'Faculty' AND
			m.id = f.id
	);

/*
Write an SQL statement to find the titles of books authored by an author having first name as 'Joh Paul' and last name as 'Mueller'
*/

SELECT
	title
FROM
	book_catalogue b
NATURAL JOIN book_authors ba
WHERE
	ba.author_fname = 'Joh Paul' AND
	ba.author_lname = 'Mueller';

/*
Write a SQL statement to find the titles of books published by 'McGraw Hill Education'
*/

SELECT
	title
FROM
	book_catalogue
WHERE
	publisher = 'McGraw Hill Education';

/*
Write a SQL statement to display the first name and the last name of students (student_fname, student_lname) pursuing 'PG' courses
*/

SELECT
	student_fname,
	student_lname
FROM
	students s
NATURAL JOIN members
WHERE
	member_type = 'PG';