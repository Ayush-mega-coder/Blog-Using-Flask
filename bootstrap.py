import flask
from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def hello_world():
    return render_template('index.html')

@app.route("/about")
def about():
    name="Ayush"
    return render_template('about.html', name2= name)

@app.route("/bootstrap")
def bootstrap():
    return render_template('bootstrap.html')

@app.route("/a")
def a():
    return render_template('a.html')


#app.run runs the app on the server and debug=true automatically detect the change in program and update the content

app.run(debug=True)