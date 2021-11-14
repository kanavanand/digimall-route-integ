import json
import time
import datetime
import requests
import pandas as pd
from firebase_admin import firestore
from firebase_admin import auth
from flask_cors import CORS,cross_origin
from flask import Flask,request,jsonify,Blueprint
from __init__ import db_prod,db_dev,app_dev,app_prod
from constants import (slackURL,url_order,url_order_status)
from config import (MOBILE_NUMBER)

# db_prod = db_dev

web_catalogue = Blueprint('WebCatalogue',__name__)
CORS(web_catalogue)

############# web catalogue ##########
@web_catalogue.route('/web/getallproducts', methods=['GET'])
def get_all_products():
    uuid = request.args['token']
    users_ref = db_prod.collection(u'Stores').document(u'{}'.format(uuid)).collection(u'Products').order_by(u'timestamp',direction=firestore.Query.DESCENDING)
    docs = users_ref.stream()
    products=[]
    for i in docs:
        order_ = i.to_dict()
        order_['id']=i.id
        order_["productImageUrl"]=""
        order_["subCategory"]=""
        if order_['availability']:
            products.append(order_)
    return jsonify(products)


@web_catalogue.route('/web/shopinfo', methods=['GET'])
def ger_shop_info():
    uuid = request.args['token']
    users_ref = db_prod.collection(u'Stores').document(u'{}'.format(uuid))
    shopInfo = users_ref.get().to_dict()
    shopObject={}
    if "minimumOrderAmount" in shopInfo.keys():
        shopObject["minimumOrderAmount"] = shopInfo['minimumOrderAmount']
    else:
        shopObject["minimumOrderAmount"] =0

    shopObject['name'] = shopInfo['name']
    return jsonify(shopObject)



@web_catalogue.route('/web/orders', methods=['GET'])
def get_all_orders():
    uuid = request.args['token']
    all_orders=[]
    users_ref = db_prod.collection(u'Orders').where(u'orderedBy',u'==',u'{}'.format(uuid)).order_by(u'timestamp',direction=firestore.Query.DESCENDING)
    docs = users_ref.stream()
    for i in docs:
        order_ = i.to_dict()
        order_['id']=i.id
        all_orders.append(order_)
    return jsonify(all_orders)


@web_catalogue.route('/web/useraddress', methods=['GET'])
def get_all_address():
    uuid = request.args['token']
    doc = db_prod.collection(u'Users').document(u'{}'.format(uuid))
    userInfo = doc.get().to_dict()
    return jsonify(userInfo['addresses'])



@web_catalogue.route('/web/add_new_address', methods=['POST'])
def add_new_address():
    token = request.json['token']
    address = request.json['address']
    doc = db_prod.collection(u'Users').document(u'{}'.format(token)).update({u'addresses': firestore.ArrayUnion([address])})
    return {"status":200}




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



@web_catalogue.route('/web/placeorder', methods=['POST'])
def place_order():
    userId = request.json['userId']
    storeId = request.json['storeId']
    address = request.json['address']
    cart = json.loads(request.json['cart'])
    total = request.json['total']
    totalItems = request.json['totalItems']
    storeDoc = db_prod.collection('Stores').document(storeId)
    storeObj = storeDoc.get().to_dict()

    userDoc = db_prod.collection('Users').document(userId)
    userObj = userDoc.get().to_dict()



    orderObje = {}
    delivCharges=0

    user = auth.get_user(userId,app=app_prod)
    phone_number = user.phone_number


    orderObje['address'] = address
    orderObje['items']=totalItems
    orderObje['storeName'] = storeObj['name']
    orderObje['storeId'] = storeObj['id']
    orderObje['sellerContactNo'] = storeObj['number']
    orderObje['orderedBy'] = userId
    orderObje['userContactNo'] =phone_number
    orderObje['userName'] = "userName"
    orderObje['orderNo'] = 0
    orderObje['userName'] = "userName"
    orderObje['payment']="cash"
    orderObje['orderStatus']="pending"
    orderObje['timestamp']=firestore.SERVER_TIMESTAMP
    orderObje['cart'] = cart
    try:
        print("Deliv charges not there")
        delivCharges = storeObj['deliveryCharges']
    except:
        delivCharges
    orderObje['orderDetails']={
        "deliveryCharges":delivCharges,
        "discount":0,
        "grandTotal":total,
        "storeName":storeObj['name'],
        "storeId":storeObj['id'],
        "totalPrice":total}

    doc = db_prod.collection(u'Orders').document()
    doc.set(orderObje)

    divider = "-"*150
    TEXT = "IOS APP  \n buyer = {} \nseller = {} \nTotal Items = {} \n Address = {}  \nCost = {} \n {} \n {} \n".format(orderObje['userContactNo'],orderObje['storeName'],totalItems,orderObje['address'],total,str(orderObje['cart']),divider)
    response = requests.post(url_order ,data = json.dumps({"text":TEXT}))
    route_order_placed(phone_number,total)

    return {"status":200}


    # from firebase_admin import auth
    # cart={}
    # total=100
    # totalItems=3
    # address = "109 a basant avenue"

    # storeId="Iarw1pbKs5RTxqrvudl9YcY3Qf72"
    # userId="Iarw1pbKs5RTxqrvudl9YcY3Qf72"

