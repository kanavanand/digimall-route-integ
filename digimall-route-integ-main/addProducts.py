import json
import time
import datetime
import requests
import pandas as pd
from firebase_admin import firestore
from flask import Flask,request,jsonify,Blueprint
from flask_cors import CORS,cross_origin
from config import (numberOfItems,MOBILE_NUMBER)
from constants import (slackURL,url_order,url_order_status)
from datahandler import (FOOD_DATA,PRODUCT_DATA)
from utils import nameKeywordsGenerator
from __init__ import db_dev


admin_add_products = Blueprint('AminAddProducts',__name__)
CORS(admin_add_products)



def route_product_added(message):
    url = "https://rapidapi.rmlconnect.net/wbm/v1/message"
    number = f"+91{MOBILE_NUMBER}"
    payload = json.dumps({
    "phone": number,
    "media": {
        "type": "media_template",
        "template_name": "welcome",
        "body": [
                    {
                        "text": f"-----------------PRODUCT UPDATE-----------------{message}----------------------------------"
                    }
                ]
        }
        }
    )
    headers = {
    'Content-Type': 'application/json',
    'Authorization': '617bf1ac245383001100f7cb'
    }
    response = requests.request("POST", url, headers=headers, data=payload)
    print(response.text)
@admin_add_products.route('/v1/addproduct', methods=['POST'])
def addProduct():
    agent_info=request.json['agent_info']
    docFirebase  = db_dev.collection('Stores').document(agent_info['shopInfo']['key']).collection('Products').document()
    prodId=  docFirebase.id
    prodInfo=  agent_info['productDetail']
    #####
    prodInfo['productId']=prodId
    prodInfo['code']=  "1234"
    prodInfo['mrp']=  int(prodInfo['mrp'])
    prodInfo['sellingPrice']=  int(prodInfo['sellingPrice'])
    prodInfo['timestamp'] = datetime.datetime.now()
    prodInfo['availability'] = True
    prodInfo['searchKey']=  str(prodInfo['name']).lower()
    prodInfo['keywords'] = nameKeywordsGenerator(prodInfo['name'])

    docFirebase.set(prodInfo)
    nameAdmin = agent_info['admin']
    prodName = agent_info['productDetail']['name']
    store = agent_info['shopInfo']['text']
    TEXT = "{0} added {1} to {2} mrp::- {3} SP::-{4}".format(nameAdmin ,prodName ,  store ,str(prodInfo['mrp']) ,str(prodInfo['sellingPrice'])  )
    response = requests.post(slackURL ,data = json.dumps({"text":TEXT}))
    route_product_added(TEXT)
    return "hello"





@admin_add_products.route('/v1/storedetails', methods=['GET'])
def storeDetails():
    users_ref = db_dev.collection(u'Stores')
    docs = users_ref.stream()
    storeObjects=[]
    for doc in docs:
        storeDetails =doc.to_dict()
        storeDetails = "{}".format(str(storeDetails['name'])) 
        storeObjects.append({"text":storeDetails , "key":doc.id ,"value":doc.id})
    return jsonify(storeObjects)


@admin_add_products.route('/v1/addapp', methods=['GET'])
def addAppForUser():
    query= request.args['query']## can be converted to headers instead 
    category = request.args['category']
    topicMain = request.args['topic']
    if topicMain=='food':
        data= FOOD_DATA
    else:
        data = PRODUCT_DATA
    if category!="All Items":
        data = data.loc[data.Category == category]
    word=query
    records = data[data.productName.apply(lambda x : word.lower() in x.lower() )][['Category','productName','productImageUrl','productImage']].head(numberOfItems).to_dict(orient='records')

    return jsonify(records)

@admin_add_products.route('/', methods=['GET'])
def mhome():
    return "Hello World"


def route_order_placed(number_buyer,cartval):
    url = "https://rapidapi.rmlconnect.net/wbm/v1/message"
    number = f"+91{MOBILE_NUMBER}"
    payload = json.dumps({
    "phone": number,
    "media": {
        "type": "media_template",
        "template_name": "order_place",
        "body": [
                    {
                        "text": "Seller"
                    },
                    {
                        "text": "DigiMall"
                    },
                    {
                        "text": f"of Rs.{cartval}"
                    },
                    {
                        "text": number_buyer
                    }
                ]
        }
        }
    )
    headers = {
    'Content-Type': 'application/json',
    'Authorization': '617bf1ac245383001100f7cb'
    }
    response = requests.request("POST", url, headers=headers, data=payload)
    print(response.text)




@admin_add_products.route('/v1/notifyorder', methods=['POST'])
def recievedOrder():
    dic=  request.form.to_dict()
    divider = "-"*150
    TEXT = "buyer = {} \nseller = {} \nTotal Items = {} \n Address = {}  \nCost = {} \n {} \n ".format(dic['buyer'],dic['seller'],dic['total_item'],dic['address'],dic['cartValue'],divider)
    response = requests.post(url_order ,data = json.dumps({"text":TEXT}))
    route_order_placed(dic['buyer'],dic['cartValue'])
    return "success"



def route_accept_order():
    username = "rapid-JhjT8380910000"
    password = "617bf1ac245383001100f7cb"
    number = f"+91{MOBILE_NUMBER}"
    message="""Dear Surbhi,
Thanks for choosing DigiMall superfast services
Your order is accepted and will be shipped.
If you have any problems/queries feel free to call us 8436945999.
Team DigiMall 
    """
    url = f"https://rapidapi.rmlconnect.net:9443/bulksms/bulksms?username={username}&password={password}&type=0&dlr=1&destination={number}&source=RMLPRD&message={message}"
    payload={}
    headers = {}
    response = requests.request("GET", url, headers=headers, data=payload)
    print(response.text)


@admin_add_products.route('/v1/acceptordernoti', methods=['GET'])
def acceptNotification():
    number= request.args['number']
    TEXT = "Your order is accepted and will be delivered soon!"
    divider = "-"*150
    WhatsappMessage= "Order Accepted for {} \n <https://api.whatsapp.com/send/?phone={}&text={}&app_absent=0>\n\n{}\n\n".format(number, number,TEXT,divider)
    response = requests.post(url_order_status ,data = json.dumps({"text":WhatsappMessage}))
    route_accept_order()
    return "success"
