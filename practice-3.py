import psycopg2
import os
import sys

with open("player.txt", 'r') as f:
    name = f.readline().split()[0]

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
        jersey_no
    FROM
        players
    WHERE
        name = %s
    """
    cur.execute(query, (name,))
    res = cur.fetchone()
    print(res[0])
except Exception as error:
    print(error)
finally:
    if conn is not None:
        conn.close()