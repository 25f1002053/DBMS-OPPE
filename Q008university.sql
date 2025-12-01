/*
Write an SQL query to find the names of instructors whose department is in the building 'Taylor', 'Main' or 'Lambeau'
*/

SELECT
    name
FROM
    instructor i
JOIN department d ON d.dept_name = i.dept_name
WHERE 
    building IN ('Taylor', 'Main', 'Lambeau');