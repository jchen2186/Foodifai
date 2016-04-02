# flaskr.py    
from flask import Flask, request, render_template, redirect, url_for
from app import views
from clarifai.client import ClarifaiApi

app = Flask(__name__)

@app.route('/', methods=['GET','POST'])
def home(): 
    if request.method == 'GET':
        url = request.form['url']
        clarifai_api = ClarifaiApi(model='EDITHERE')
        result = clarifai_api.tag_image_url(#SOMETHING)
        return(result)    
        return redirect(url_for('tags'))
                        
@app.route('/tags')
def tags():
    # here is where the clarifai api will take in the url
    return render_template('welcome.html') 

if __name__ == "__main__":
    app.run()
