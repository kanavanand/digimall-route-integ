
import json
import requests
import numpy as np
import pandas as pd
from random import randint
from flask_cors import CORS
from flask_pymongo import PyMongo
from flask import request, jsonify, render_template, Blueprint
import time
from flask_cors import CORS,cross_origin



app_playground = Blueprint('AppPlayground',__name__)
CORS(app_playground )

#### App
@app.route('/v1/addapp', methods=['POST'])
def addAppForUser():
    '''
    Adds new app for you on clicking the plus sign this ensures the 
    App is added to the DB
    '''
    
    return "hello world"