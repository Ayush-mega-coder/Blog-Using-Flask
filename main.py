import flask
from flask_mail import Mail
from flask import Flask, render_template,session,request,redirect
from datetime import datetime
import json
import math
import os
from werkzeug.utils import secure_filename
from flask_sqlalchemy import SQLAlchemy


with open('config.json', 'r') as c:
    params = json.load(c)['params']


local_server = True
app = Flask(__name__)
app.secret_key = 'super secret key'
app.config['UPLOAD_FOLDER'] = params['upload_location']
#automarically send the form to email
app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT ='465',
    MAIL_USE_SSL =True,
    MAIL_USERNAME = params['gmail-user'],
    MAIL_PASSWORD = params['gmail-password']
)
mail = Mail(app)


if(local_server):

    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']


db = SQLAlchemy(app)

class Contacts(db.Model):

    # sno, Name, email, phone_no, message, data


    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=True)
    email = db.Column(db.String(20))
    phone_no= db.Column(db.String(12))
    message = db.Column(db.String(120))
    date = db.Column(db.String(12), nullable=True)


class Posts(db.Model):

    # sno, Name, email, phone_no, message, data


    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=True)
    slug = db.Column(db.String(20))
    content= db.Column(db.String(120))
    date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(20), nullable=True)
    tagline = db.Column(db.String(50), nullable=True)




@app.route("/")
def home():
    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts)/int(params['number_of_post']))
    # [0:params['number_of_post']]



    page = request.args.get('page')
    if(not str(page).isnumeric()):
        page = 1
    page=int(page)
    posts = posts[(page-1)*int(params['number_of_post']): (page-1)*int(params['number_of_post']) + int(params['number_of_post'])]

    if page==1:
        prev = "#"
        next = "/?page=" +str(page+1)
    elif page==last:
        prev = "/?page=" + str(page -1)
        next = "#"

    else:
        prev = "/?page=" + str(page -1)
        next = "/?page=" + str(page+1)


    return render_template('index.html', params=params, posts=posts, prev=prev,next=next)










    #we need to fetch some posts from the database and we have used for loop in html file


#using post_slug, getting psot form db
@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):

    #fetching post from db
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params, post=post)

@app.route("/about")
def about():
    return render_template('about.html' , params=params)

#making route for sign in dashboard
#methods get,post for validating signin
@app.route("/dashboard", methods=['GET', 'POST'] )
def dashboard():

    if ('user' in session and session['user'] == params['admin_user']):
        posts = Posts.query.all()
        return render_template('dashboard.html', params=params, posts =posts)




    if flask.request.method=='POST':
        username = flask.request.form.get('uname')
        userpass = flask.request.form.get('pass')

        if(username == params['admin_user'] and userpass == params['admin_password']):
            # set the session variable
            session['user'] = username
            posts = Posts.query.all()
            return render_template('dashboard.html', params=params , posts =posts)


    return render_template('login.html' , params=params)




@app.route("/post")
def post():
    return render_template('post.html', params=params)






@app.route("/edit/<string:sno>", methods=['GET','POST'])
def edit(sno):
    if ('user' in session and session['user'] == params['admin_user']):

        if request.method == 'POST':
            box_title = request.form.get('title')
            tline = request.form.get('tline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            date = datetime.now()

            if sno =='0':
                post = Posts(title = box_title, slug=slug, tagline=tline, content=content, img_file=img_file,date=date)
                db.session.add(post)
                db.session.commit()

            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.title = box_title
                post.slug = slug
                post.tagline = tline
                post.content = content
                post.date = date
                post.img_file = img_file

                db.session.commit()
                return redirect('/edit/' +sno)

        post = Posts.query.filter_by(sno=sno).first()

        return render_template('edit.html', params=params, post=post,sno=sno)


@app.route("/uploader", methods=['GET','POST'])
def uploader():
    if ('user' in session and session['user'] == params['admin_user']):


        if (request.method == 'POST'):

            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return "Upload success"

@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/dashboard')


@app.route("/delete/<string:sno>", methods=['GET','POST'])
def delete(sno):

    if ('user' in session and session['user'] == params['admin_user']):
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')






@app.route("/contact", methods=['GET','POST'])
def contact():
    if(flask.request.method=='POST'):

        '''Add entry to the database'''

        name = flask.request.form.get('name')
        email = flask.request.form.get('email')
        phone = flask.request.form.get('phone')
        message = flask.request.form.get('message')

        entry = Contacts(name=name, phone_no = phone, message=message, email=email, date=datetime.now())
        db.session.add(entry)
        db.session.commit()
        mail.send_message('New message from ' + name,
                          sender=email,
                          recipients=[params['gmail-user']],
                          body = message + "\n" + phone

                          )





    return render_template('contact.html', params=params)


#app.run runs the app on the server and debug=true automatically detect the change in program and update the content

app.run(debug=True)