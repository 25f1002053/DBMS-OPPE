import psycopg2
import os
import sys

def formatName(name):
    lastname = name.split()[-1]
    initials = [i[0]+'.' for i in name.split()[:-1]]
    return f"{lastname} {' '.join(initials)}"

with open("date.txt", 'r') as f:
    date = f.readline().split()[0]

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
        r.name
    FROM
        referees r
    JOIN match_referees mr ON mr.referee = r.referee_id
    JOIN matches m ON m.match_num = mr.match_num
    WHERE
        match_date = %s
    """
    cur.execute(query, (date,))
    res = cur.fetchone()
    print(formatName(res[0]))
except Exception as error:
    print(error)
finally:
    if conn is not None:
        conn.close()