/*
Write an SQL query to find the player IDs of the players whose name ends with 'a'
*/

SELECT
    player_id
FROM
    players
WHERE
    name LIKE '%a';

/*
Write an SQL query to find the names of the guest team of the match which was played on '2020-05-21'
*/

SELECT
    name
FROM
    teams t
JOIN matches m ON m.guest_team_id = t.team_id
WHERE
    match_date = '2020-05-21';

/*
Write an SQL query to find the name, dob and the respective team name and the manager name of each player whose jersey number is '39'
*/

SELECT
    p.name,
    p.dob,
    t.name,
    m.name
FROM players p
JOIN teams t ON t.team_id = p.team_id
JOIN managers m ON m.team_id = p.team_id
WHERE
    jersey_no = 39;