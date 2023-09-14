from flask import Blueprint, render_template, request, current_app, url_for, redirect, session

views = Blueprint('views', __name__)


@views.route('/')
def root():
    if not session.get('username'):
        return redirect('/login')

    return render_template('home.html', flag='COMP6441{NOT_A_REAL_FLAG}', username=session['username'])


@views.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'GET':
        return render_template('login.html')

    username = request.form.get('username', None)
    password = request.form.get('password', None)

    result = current_app.config['DATABASE'].auth(username, password)
    if result:
        session['username'] = result[0]
        return redirect(url_for('views.root')), 302
    else:
        return render_template('login.html', error='no lmao'), 400


@views.route('/logout', methods=['GET'])
def logout():
    if 'username' in session:
        del session['username']

    return redirect(url_for('views.login')), 302
