import psycopg2
import os
import sys

def shiftCipher(text: str):
    res = ''
    for i in text:
        if i.isalpha():
            pos = (ord(i) - ord('A') + 1 + 7) % 26
            res += chr(ord('A') + pos - 1)
        elif i.isdigit():
            pos = (ord(i) - ord('0') + 7) % 10
            res += chr(ord('0') + pos)
    return res

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
        team_id
    FROM
        teams
    WHERE
        jersey_home_color <> jersey_away_color
    """
    cur.execute(query)
    res = cur.fetchall()
    for row in res:
        print(shiftCipher(row[0]))
    
except Exception as error:
    print(error)
finally:
    if conn is not None:
        conn.close()