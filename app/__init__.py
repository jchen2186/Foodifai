# flaskr.py    
from flask import Flask, request, render_template, redirect, url_for
# from app import views
from clarifai.client import ClarifaiApi

app = Flask(__name__)

@app.route('/', methods=['GET','POST'])
def home():
    return render_template('welcome.html')

@app.route('/tags', methods=['GET'])
def tags():
    return(request.args["url"])
                        

if __name__ == "__main__":
    app.run()

# https://upload.wikimedia.org/wikipedia/commons/thumb/9/9c/2007feb-sushi-odaiba-manytypes.jpg/435px-2007feb-sushi-odaiba-manytypes.jpg

'''

        clarifai_api = ClarifaiApi(model='EDITHERE')
        result = clarifai_api.tag_image_url(#SOMETHING)
        '''
