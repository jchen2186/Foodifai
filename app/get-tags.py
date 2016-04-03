from flask import Flask, request, render_template, redirect, url_for
# from app import views
from clarifai.client import ClarifaiApi


@app.route('/tags')
def tags(result):
    print(result)
    # here is where the clarifai api will take in the url
