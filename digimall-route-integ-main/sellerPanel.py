import json
import time
import datetime
import requests
import pandas as pd
from firebase_admin import firestore
from flask import Flask,request,jsonify,Blueprint
from flask_cors import CORS,cross_origin
from __init__ import db_prod,db_dev
# db_prod = db_dev

seller_panel = Blueprint('SellerPanel',__name__)
CORS(seller_panel)


@seller_panel.route('/admin/orders', methods=['GET'])
def allOrders():
    uuid = request.args['token']
    all_orders=[]
    users_ref = db_prod.collection(u'Orders').where(u'storeId',u'==',u'{}'.format(uuid)).order_by(u'timestamp',direction=firestore.Query.DESCENDING)
    docs = users_ref.stream()
    for i in docs:
        order_ = i.to_dict()
        order_['id']=i.id
        all_orders.append(order_)
    new_orders = [order for order in all_orders if order['orderStatus'] == 'pending']
    confirmed_orders = [order for order in all_orders if order['orderStatus'] == 'confirmed']
    OrderObject = {"AllOrders":all_orders,"NewOrders":new_orders , "ConfirmedOrders":confirmed_orders}
    return jsonify(OrderObject)




def route_accept_order():
    username = "rapid-JhjT8380910000"
    password = "617bf1ac245383001100f7cb"
    number = "+918436945999"
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


@seller_panel.route('/admin/acceptorders', methods=['GET'])
def accept_orders():
    orderId= request.args['orderId']
    token= request.args['token']

    db_prod.collection(u'Orders').document(orderId).update({'orderStatus':"confirmed"})
    ref = db_prod.collection(u'Orders').document(orderId)
    total = ref.get().to_dict()['orderDetails']['grandTotal']
    user_ref = db_prod.collection(u'Stores').document(token)
    shopInfo = user_ref.get()
    shopInfoObject = shopInfo.to_dict()
    anallytics=   shopInfoObject['analytics']
    anallytics['orders']=anallytics['orders']+1
    anallytics['sales']=anallytics['sales']+total
    db_prod.collection(u'Stores').document(token).update({'analytics':anallytics})
    route_accept_order()
    return "success"

@seller_panel.route('/admin/rejectorders', methods=['GET'])
def reject_orders():
    orderId= request.args['orderId']
    db_prod.collection(u'Orders').document(orderId).update({'orderStatus':"rejected"})
    return "success"


@seller_panel.route('/admin/productList', methods=['GET'])
def getProductList():
    uuid = request.args['token']
    users_ref = db_prod.collection(u'Stores').document(u'{}'.format(uuid)).collection(u'Products').order_by(u'timestamp',direction=firestore.Query.DESCENDING)
    docs = users_ref.stream()
    products=[]
    for i in docs:
        order_ = i.to_dict()
        order_['id']=i.id
        products.append(order_)
    return jsonify(products)

@seller_panel.route('/admin/checkauth', methods=['POST'])
def checkAUTH():
    token = request.json['token']
    users_ref = db_prod.collection(u'Stores')
    ls_users=[]
    for i in users_ref.stream():
        ls_users.append(i.id)
    if token in ls_users:
        print("authenticated")
        return{"status":200}
    else:
        return {"status":400}


@seller_panel.route('/admin/shopinfo', methods=['GET'])
def getUserData():
    uuid = request.args['token']
    users_ref = db_prod.collection(u'Stores').document(u'{}'.format(uuid))
    shopInfo = users_ref.get()
    shopInfoObject = shopInfo.to_dict()
    shopNewObject ={}
    shopNewObject["name"]=shopInfoObject["name"]
    shopNewObject["image"]=shopInfoObject["image"]
    shopNewObject["image"]=shopInfoObject["image"]
    shopNewObject['dynamicLinkUrl'] = shopInfoObject['dynamicLinkUrl']
    try:
        shopNewObject["number"]=shopInfoObject["number"]
    except:
        print("number not there")
    shopNewObject["analytics"]=shopInfoObject["analytics"]
    return  jsonify(shopNewObject)


@seller_panel.route('/admin/updatedata', methods=['POST'])
def updateData():
    token = request.json['token']
    prodID = request.json['prodID']
    avail = request.json['avail']
    name = request.json['name']
    quantity = request.json['quantity']
    mrp = request.json['mrp']
    sellingPrice = request.json['sellingPrice']
    users_ref = db_prod.collection(u'Stores').document(u'{}'.format(token)).collection('Products').document(prodID).update({
        "availability":avail,
        "name":name,
        "quantity":quantity,
        "mrp":int(mrp),
        "sellingPrice":int(sellingPrice)
    })
    return {"status":200}



############# web catalogue ##########
@seller_panel.route('/admin/getallproducts', methods=['GET'])
def get_all_products():
    uuid = request.args['token']
    users_ref = db_prod.collection(u'Stores').document(u'{}'.format(uuid)).collection(u'Products')
    docs = users_ref.stream()
    products=[]
    for i in docs:
        order_ = i.to_dict()
        order_['id']=i.id
        products.append(order_)
    return jsonify(products)