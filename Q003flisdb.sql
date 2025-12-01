/*
Write an SQL query to find the match number where the host team ID is 'T0004' and the guest team ID is 'T0002'
*/

SELECT
    match_num
FROM
    matches
WHERE
    host_team_id = 'T0004' AND
    guest_team_id = 'T0002';