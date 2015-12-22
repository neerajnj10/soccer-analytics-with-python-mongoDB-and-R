#### conda install pymongo
#### conda install/update jupyter
#### jupyter/ipython notebook
"""
connecting with mongoDB in localhost
"""

#pymongo module for making connection wth mongoDB

from pymongo import MongoClient

#we specify the localhost connection at port `27017` for a specific reason which is discussed in the mongoelastic file.

client = MongoClient("mongodb://localhost:27017/")

# spainsoccer is our databse we have created
db = client['spainsoccer']

# liga_data is the collection we have created. Collections are documents inside the databases that stores the actual data. A single 
#database can have several collections.

collections = db['liga_data']

#using insert method to finally insert the data into our colelction-liga_data of spainsoccer database
collections.insert(readings_df)
