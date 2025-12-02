import psycopg2
import os
import sys

with open("name.txt", 'r') as f:
    date = f.readline().split()[0]

try:
    conn = psycopg2.connect(
                database = sys.argv[1],
                user = os.environ.get('PGUSER'),
                password = os.environ.get('PGPASSWORD'),
                host = os.environ.get('PGHOST'),
                port = os.environ.get('PGPORT')
            )
    curr = conn.cursor()
    query = """
    SELECT
        roll_no
    FROM
        students
    WHERE
        student_fname = %s
    """
    curr.execute(query, (date,))
    res = curr.fetchone()
    print(res[0])
except Exception as error:
    print(error)
finally:
    if conn is not None:
        conn.close()
    