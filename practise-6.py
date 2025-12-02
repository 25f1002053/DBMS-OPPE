import psycopg2
import os
import sys

with open("name.txt", 'r') as f:
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
        student_fname,
        department_name,
        dob
    FROM
        students s
    JOIN departments d ON d.department_code = s.department_code
    WHERE
        student_fname = %s
    """
    cur.execute(query, (name,))
    res = cur.fetchone()
    year = int(str(res[2])[:4])
    if year % 2 == 0:
        parity = 'Even'
    else:
        parity = 'Odd'
    print(res[0]+','+res[1]+','+parity)
except Exception as error:
    print(error)
finally:
    if conn is not None:
        conn.close()
