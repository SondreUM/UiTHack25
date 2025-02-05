import sqlite3

conn = sqlite3.connect("database.sqlite")
c = conn.cursor()
c.execute("""CREATE TABLE secret (key TEXT, flag TEXT)""")
c.execute(
    "INSERT INTO secret (key, flag) VALUES ('asdfmjpagy0123jgla09+213kasgf032', 'UiTHack25{DaTaBaseS_Expl0it4t10n}')"
)
conn.commit()
conn.close()
