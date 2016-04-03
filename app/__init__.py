# flaskr.py
from flask import Flask, request, render_template, redirect, url_for
# from app import views
from clarifai.client import ClarifaiApi
import sys
import os
from os import listdir
from os.path import isfile, join

app = Flask(__name__)


@app.route('/', methods=['GET', 'POST'])
def home():
    return render_template('welcome.html')


@app.route('/tags', methods=['GET'])
def tags():
    url = request.args["url"]
    # pathName = "templates/tags.html"
    fo = open("tags.html", 'w')
    html_str = '''
    <html>
        <head></head>
        <body><img src ="%s" /></body>
    </html>
    '''
    fo.write(html_str % url)

    return html_str % url

if __name__ == "__main__":
    app.run()

# https://upload.wikimedia.org/wikipedia/commons/thumb/9/9c/2007feb-sushi-odaiba-manytypes.jpg/435px-2007feb-sushi-odaiba-manytypes.jpg

'''

        clarifai_api = ClarifaiApi(model='EDITHERE')
        result = clarifai_api.tag_image_url(#SOMETHING)
        '''
