/*
Write an SQL query to find the title of the courses that belongs to the 'Statistics' department
*/

SELECT
    title
FROM
    course c
JOIN department d ON d.dept_name = c.dept_name
WHERE 
    d.dept_name = 'Statistics';