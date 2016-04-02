# flaskr.py    
from flask import Flask, request, render_template, redirect, url_for
from app import views
from clarifai.client import ClarifaiApi

app = Flask(__name__)

@app.route('/')
def home(): #homepage; gotta edit the
    if request.method == 'GET':
        url = request.form['url']
        return redirect(url_for('tags')
                        
@app.route('/tags')
def tags():
    # here is where the clarifai api will take in the url
    return render_template('welcome.html') 

if __name__ == "__main__":
    app.run()
