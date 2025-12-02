import psycopg2
import os
import sys

with open("team.txt", 'r') as f:
    team_id = f.readline().split()[0]

try:
    conn = psycopg2.connect(
        database = sys.argv[1],
        user = os.environ.get("PGUSER"),
        password = os.environ.get("PGPASSWORD"),
        host = os.environ.get("PGHOST"),
        port = os.environ.get("PGPORT")
    )
    cur = conn.cursor()
    query = """
    SELECT
        playground
    FROM
        teams
    WHERE
        team_id = %s
    """
    cur.execute(query, (team_id,))
    res = cur.fetchone()
    print(res[0])
except Exception as error:
    print(error)
finally:
    if conn is not None:
        conn.close()
    
