# flaskr.py    
from flask import Flask
from app import views

app = Flask(__name__)

@app.route('/')
def home(): #homepage; gotta edit the 
    return render_template('welcome.html') 

if __name__ == "__main__":
    app.run()
