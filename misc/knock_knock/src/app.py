from time import time
from flask import Flask, session, request
from werkzeug import exceptions


app = Flask('knock_knock')
app.secret_key = 'mbJMJ6G7fhlkA8U6cBDGTJTWFe6Xs9P2'

# max time (in seconds) before the session resets
MAX_TIME = 5

'''
To make this challenge more newcomer-friendly it only uses HTTP and no other protocols. 
This also lets us manage sessions with cookies. 
'''

def run():
    app.run('0.0.0.0', port=8080)


@app.before_request
def check_request():
    '''
    This method is used for state management.
    By proxying different ports to the same web server we simplify the application logic.
    Headers are used to identify ports and are added by nginx when proxying.
    The 'state' session variable manages the users state internally.
    '''
    # check first port
    if 'X-First-Port' in request.headers:
        session['state'] = 1
        session['start_time'] = time()
        print('user hit first port!')
    # abort all other connections if not a valid port
    if not 'state' in session or not 'start_time' in session:
        # print('invalid request!')
        return
    # check timer and reset if necessary, but not after user has completed the sequence
    if session['start_time'] + MAX_TIME < time() and not session['state'] == 3:
        session.clear()
        return
    # check second port
    if session['state'] >= 1 and 'X-Second-Port' in request.headers:
        session['state'] = 2
        print('user hit second port!')
    # check third port
    if session['state'] >= 2 and 'X-Third-Port' in request.headers:
        session['state'] = 3
        print('user hit third port!')


@app.errorhandler(404)
def not_found(e):
    # Custom 404 page to further mask hidden endpoints
    return 'Nothing to see here!', 404


@app.route('/')
def home():
    if 'state' in session and session['state'] == 3:
        return 'Welcome! Here is your flag: UiTHack25{Wh05_Th3r3?_N0t_Th3_f3d5}'
    return 'This is a totally normal website. Go away!'


@app.route('/giokcTgkl1yXuw0bkVXDLUyA87pL3HHN')
def first_port():
    return f'<p>Hello there... your next port is <b>53254</b>. Be quick, you only have {MAX_TIME} seconds!</p><p>Also, take this cookie. It will let us identify you later on.</p>'


@app.route('/LNZInlBVjVSeXs1js3kycd85v58MfRHY')
def second_port():
    if not 'state' in session or session['state'] < 2:
        return 'Nothing to see here!', 404
    return 'Good work so far... the final port is <b>1337</b>.'


@app.route('/oSTgb3HbydXkLy08xF1e6BogGFMr5JEr')
def third_port():
    if not 'state' in session or session['state'] < 3:
        return 'Nothing to see here!', 404
    return 'You have proven yourself. You may now return to the <b>home page</b> and access the facility.'


if __name__ == "__main__":
    run()
