# flaskr.py
from flask import Flask, request, render_template, redirect, url_for
# from app import views
from clarifai.client import ClarifaiApi
import sys
import os
from os import listdir
from os.path import isfile, join
from clarify_python import clarify
import foursquare

app = Flask(__name__) #, template_folder=template_path)


@app.route('/', methods=['GET', 'POST'])
def home():
    return render_template('welcome.html')

@app.route('/tags', methods=['GET'])
def tags():
    url = request.args["url"] 
    clarifai_api = ClarifaiApi()  # assumes environment variables are set.
    result = clarifai_api.tag_image_urls(url)
    results = result['results'][0]["result"]["tag"]["classes"]#[:3]

    client = foursquare.Foursquare(client_id='JEK02X44TGMNJSE0VC1UBEB4FRNNW3UMFQ4IQOPI4BAR2GXA', \
                                    client_secret='A2Z50VTUHHXEUYJBHCQKB1LXTNVVBYBQR4SDASVTXTWUMWXS') #foursquare shit

    
    foursquare_dictionary = client.venues.explore(params={'ll': '40.7, -74', 'v': '20160402', 'query': results[0] + ',' + results[1] + ',' + results[2]})

    #first place to eat
    # status1 = foursquare_dictionary['groups'][0]['items'][0]['venue']['hours']['status']
    address = foursquare_dictionary['groups'][0]['items'][0]['venue']['location']['formattedAddress']
    name = foursquare_dictionary['groups'][0]['items'][0]['venue']['name']

    #second place to eat
    address2 = foursquare_dictionary['groups'][0]['items'][1]['venue']['location']['formattedAddress']
   # status2 = foursquare_dictionary['groups'][0]['items'][1]['venue']['hours']['status']
    name1 = foursquare_dictionary['groups'][0]['items'][1]['venue']['name']


    newAddress = ""
    for i in address:
        newAddress = newAddress + " " + i

    newAddress1 = ""
    for i in address2:
        newAddress1 = newAddress1 + " " + i
        
    
    return render_template('tags.html',\
                           newAddress = newAddress, name = name,\
                           newAddress1 = newAddress1, name1 = name1) #status2 = status2)#\
                           #newAddress2 = newAddress2, name2 = name2, status3 = status3)


if __name__ == "__main__":
    app.run(debug=True)
 
