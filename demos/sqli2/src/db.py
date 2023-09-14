import sqlite3

class Database:
    def __init__(self):
        self.db = sqlite3.connect(':memory:')

        curs = self.db.cursor()
        # in memory as there's only one user lol
        curs.execute('''
            CREATE TABLE users (
                uid INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT,
                password TEXT
            );
        ''')
        curs.execute('''
            CREATE TABLE secrets (
                uid INTEGER PRIMARY KEY AUTOINCREMENT,
                secret TEXT
            );
        ''')
        curs.execute('INSERT INTO users (username, password) VALUES ("admin", "R3@l1ystr0ngp@$Sw0rdYouw0ntgu3ss");')
        curs.execute('INSERT INTO secrets (secret) VALUES ("COMP6441{ALSO_NOT_A_REAL_FLAG}");')

        self.db.commit()

    def auth(self, username, password):
        try:
            query = f'SELECT username, password FROM users WHERE username = "{username}" AND password = "{password}"'
            return self.db.cursor().execute(query).fetchone()
        except:
            return None
