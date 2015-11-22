
"""
connecting with mongoDB in localhost
"""

from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017/")
db = client['spainsoccer']
collections = db['liga_data']
collections.insert(readings_df)
