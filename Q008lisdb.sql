/*
Write an SQL query to find the member type and the total number of members in each type. The output should be displayed in descending order of the number of members types
*/

SELECT
    member_type, count(*)
FROM
    members
GROUP BY member_type;