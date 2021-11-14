import pandas as pd
import ssl
ssl._create_default_https_context = ssl._create_unverified_context

PRODUCT_DATA = pd.read_csv("https://firebasestorage.googleapis.com/v0/b/flash-chat-c775b.appspot.com/o/final_29k_dataset.csv?alt=media&token=e91d8841-f23f-4513-bd57-c16efc665c8d")
FOOD_DATA=  pd.read_csv('https://firebasestorage.googleapis.com/v0/b/flash-chat-c775b.appspot.com/o/food_final.csv?alt=media&token=ea92fca1-f51e-40da-8427-fd74c07c0981')
FOOD_DATA['productImageUrl'] = FOOD_DATA.SubCategLink.apply(lambda x :"https://storage.googleapis.com/flash-chat-c775b.appspot.com/food_images/{}".format(x))
