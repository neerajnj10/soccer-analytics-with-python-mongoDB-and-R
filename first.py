# -*- coding: utf-8 -*-
"""
@author: Nj_neeraj
"""

import requests
#from urllib.request import urlopen
import re
from bs4 import BeautifulSoup
#import urllib.parse 
import pandas as pd

r = requests.get("http://www.football-data.co.uk/spainm.php",headers={'User-Agent': 'Mozilla/5.0'})
soup = BeautifulSoup(r.content)
#print(soup.prettify)
   
allsearch = ''

for link in soup.find_all('a'):
    mysearch= link.get('href')
    allsearch = allsearch+' '+mysearch

y = allsearch.split()
#print(y)

#extracting only division 1 games.

z = [list(x for x in y if re.search("^mmz.*.SP1.csv$",str(x)))]
z=z[0]
base_url = 'http://www.football-data.co.uk/'
complete_url = []
for i in (z):
  u = base_url +  str(i) 
  complete_url.append(u)
  #print(complete_url)
req_url = complete_url[0:11]
print(req_url)

readings = pd.DataFrame()
for m in req_url:
    reader = pd.read_csv(m,sep=',', header=0,error_bad_lines=False)
    readings = readings.append(reader)
    #print(readings.head(n=5))
readings.rename(columns={'BbMx>2.5':'BbMxTwo', 'BbAv>2.5':'BbAvTwo','BbMx<2.5':'BbMxLess','BbAv<2.5':'BbAvLess'}, inplace=True)
readings_df = readings.to_dict('records')
print(readings_df)  

"""
connecting with mongoDB in mongolab
"""

from pymongo import MongoClient

client = MongoClient("mongodb://<dbuser>:<password>@ds045614.mongolab.com:45614/spainsoccer")
db = client['spainsoccer']
collections = db['liga_data']
collections.insert(readings_df)
