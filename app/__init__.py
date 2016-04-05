
#problem: figure out how to obtain address of user without asking

from flask import Flask, request, render_template, redirect, url_for
# from app import views
from clarifai.client import ClarifaiApi
import sys
import os
from os import listdir
from os.path import isfile, join
from clarify_python import clarify
import foursquare
from geopy.geocoders import Nominatim

app = Flask(__name__) 

# converting the obtained, raw data of an address into a string
def newAddress(address):
    anonAddress = ""
    for i in address:
        anonAddress = anonAddress + " " + i
    return(anonAddress)

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

    address = request.args["address"] #address is currently a string
    geolocator = Nominatim()
    location = geolocator.geocode(address)
    newLocation = str(location.latitude) + str(", ") + str(location.longitude)
    
    
    # foursquare_dictionary = client.venues.explore(params={'ll': '40.7, -74', 'v': '20160402', 'query': results[0] + ',' + results[1] + ',' + results[2]})

    foursquare_dictionary = client.venues.explore(params={'ll': newLocation, 'v': '20160402', 'query': results[0] + ',' + results[1] + ',' + results[2]})

    #first place to eat
    # status1 = foursquare_dictionary['groups'][0]['items'][0]['venue']['hours']['status']
    address1 = foursquare_dictionary['groups'][0]['items'][0]['venue']['location']['formattedAddress']
    name = foursquare_dictionary['groups'][0]['items'][0]['venue']['name']

    #second place to eat
    address2 = foursquare_dictionary['groups'][0]['items'][1]['venue']['location']['formattedAddress']
   # status2 = foursquare_dictionary['groups'][0]['items'][1]['venue']['hours']['status']
    name1 = foursquare_dictionary['groups'][0]['items'][1]['venue']['name']

    return render_template('tags.html',\
                           newAddress1 = newAddress(address1), name = name,\
                           newAddress2 = newAddress(address2), name1 = name1,\
                           newLocation = newLocation)


if __name__ == "__main__":
    app.run(debug=True)
