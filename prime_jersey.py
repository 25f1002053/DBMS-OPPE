import psycopg2
import os
import sys

def isPrime(n):
    if n<2:
        return False
    for i in range(2, int(n**0.5)+1):
        if n%i==0:
            return False
    return True

try:
    conn = psycopg2.connect(
        database = sys.argv[1],
        user = os.environ.get('PGUSER'),
        password = os.environ.get('PGPASSWORD'),
        host = os.environ.get('PGHOST'),
        port = os.environ.get('PGPORT')
    )
    cur = conn.cursor()
    query = """
    SELECT
        jersey_no,
        p.name,
        t.name
    FROM
        players p
    JOIN teams t ON t.team_id = p.team_id
    """
    cur.execute(query)
    res = cur.fetchall()
    res.sort(key = lambda x: (x[1],x[2]), reverse=True)
    
    for row in res:
        if isPrime(row[0]):
            print(row[1] + ', ' + row[2])
except Exception as error:
    print(error)
finally:
    if conn is not None:
        conn.close()