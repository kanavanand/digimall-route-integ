import json
import time
import datetime
import requests
import pandas as pd
import firebase_admin
from firebase_admin import firestore
from firebase_admin import credentials
from flask import Flask,request,jsonify
from flask_cors import CORS,cross_origin
from config import (numberOfItems)
from constants import (slackURL,url_order,url_order_status,
                        DEV_PROJ_ID , PROD_PROJ_ID,path_dev_key,
                        path_prod_key)
from datahandler import (FOOD_DATA,PRODUCT_DATA)
from __init__ import db_dev,db_prod,app

from addProducts import admin_add_products
from sellerPanel import seller_panel
from webCatalogue import web_catalogue

app.register_blueprint(admin_add_products)
app.register_blueprint(seller_panel)
app.register_blueprint(web_catalogue)


#Load this config object for development modes
if __name__ == '__main__':
    app.run(debug=True)