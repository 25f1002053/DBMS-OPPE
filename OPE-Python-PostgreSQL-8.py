import psycopg2
import os
import sys

def L(x):
    return 2000 + 5 * x + 5

file = open("number.txt", 'r')

try:
    conn = psycopg2.connect(
        database = sys.argv[1],
        user = os.environ.get('PGUSER'),
        password = os.environ.get('PGPASSWORD'),
        host = os.environ.get('PGHOST'),
        port = os.environ.get('PGPORT')
    )
    cur = conn.cursor()
    for x in file.readline():
        year = L(int(x))
        query = f"""
        SELECT
            ISBN_no
        FROM
            book_catalogue
        WHERE
            year = {year}
        """
        cur.execute(query)
        res = cur.fetchone()
        print(res[0])
except Exception as error:
    print(error)
finally:
    if conn is not None:
        conn.close()
