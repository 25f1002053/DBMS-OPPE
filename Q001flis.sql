/*
Write a SQL statement to find the name of the manager of the team: 'All Stars'
*/

SELECT
    m.name
FROM
    managers m
JOIN teams t ON t.team_id = m.team_id
WHERE
    t.name = 'All Stars';

/*
Write an SQL statement to find the names of all teams
*/

SELECT
    name
FROM
    teams;

/*
Write a SQL statement to find the names of teams that have played more than 3 matches
*/

SELECT
    name
FROM
    teams t
JOIN matches m ON m.host_team_id = t.team_id OR m.guest_team_id = t.team_id
GROUP BY
    name
HAVING COUNT(*) > 3;
