import firebase_admin
from flask import Flask
from firebase_admin import firestore
from firebase_admin import credentials
from config import (config)
from constants import (DEV_PROJ_ID , PROD_PROJ_ID,path_dev_key,
                        path_prod_key)

app = Flask(__name__)

print("CONFIGURING PROD")
PROJECT_ID = PROD_PROJ_ID
cred_prod = credentials.Certificate(path_prod_key)
app_prod =firebase_admin.initialize_app(cred_prod, {
'projectId': PROD_PROJ_ID,
},name="prod")

print("CONFIGURING DEV")
PROJECT_ID = DEV_PROJ_ID
cred_dev = credentials.Certificate(path_dev_key)
app_dev =firebase_admin.initialize_app(cred_dev, {
'projectId': DEV_PROJ_ID,
},name="dev")

db_dev = firestore.client(app_dev)
if config=='PROD':
    db_prod = firestore.client(app_prod)
else:
    db_prod = firestore.client(app_dev)

    
