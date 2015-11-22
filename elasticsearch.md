## Introducing elasticsearch.

> Why Elasticsearch?

- Elasticsearch is a highly scalable open-source full-text (primarily created for text but can be used for anything) search and 
analytics engine. It allows you to store, search, and analyze big volumes of data quickly and in near real time. It is generally 
used as the underlying engine/technology that powers applications that have complex search features and requirements.

**Here are a few sample use-cases that Elasticsearch could be used for:**

- You run an online web store where you allow your customers to search for products that you sell. In this case, you can use 
Elasticsearch to store your entire product catalog and inventory and provide search and autocomplete suggestions for them.

- You want to collect log or transaction data and you want to analyze and mine this data to look for trends, statistics, 
summarizations, or anomalies. In this case, you can use Logstash (part of the Elasticsearch/Logstash/Kibana stack) to collect, 
aggregate, and parse your data, and then have Logstash feed this data into Elasticsearch. Once the data is in Elasticsearch, you 
can run searches and aggregations to mine any information that is of interest to you.

- You run a price alerting platform which allows price-savvy customers to specify a rule like "I am interested in buying a 
specific electronic gadget and I want to be notified if the price of gadget falls below $X from any vendor within the next 
month". In this case you can scrape vendor prices, push them into Elasticsearch and use its reverse-search (Percolator) 
capability to match price movements against customer queries and eventually push the alerts out to the customer once matches 
are found.

- You have analytics/business-intelligence needs and want to quickly investigate, analyze, visualize, and ask ad-hoc questions 
on a lot of data (think millions or billions of records). In this case, you can use Elasticsearch to store your data and then 
use Kibana (part of the Elasticsearch/Logstash/Kibana stack) to build custom dashboards that can visualize aspects of your data 
that are important to you. Additionally, you can use the Elasticsearch aggregations functionality to perform complex business 
intelligence queries against your data.

`Source` : [official webpage](https://www.elastic.co/)


## Downloading, Installing and Getting elasticsearch up and running.

- Go to the downloads page and choose theoperating system and latest version of elastic search and download it on your system. [elastic](https://www.elastic.co/downloads/elasticsearch)
- Unzip the folder and move to `bin` sub-directory of the folder and run `elasticsearch.bat` for windows.
- Follow the instructions to check if this working by `Running curl -X GET http://localhost:9200/` , or by opening the browser and running `http://localhost:9200/` to see the notification of whether it is running.
- If you followed the download and installation steps, it will run without error.


# Why Elasticsearch with MongoDB

MongoDB is primarily the general purpose storage system, a document based databse that allows you to easily store and expand teh datasets that are **not** in any structure or format, which is the greatest advantage of the noSQL databases, that is data doesn't necessarily have to be in relational format (tablular sets), however it is sometimes slow as a **search engine** which is where `elasticsearch` comes into picture, it is not the primary source of data management or storage but is very strong as a *search engine*. Therefore utlizing the efficiency of both the systems provide effective solution for big data management specially when you are working and deploying on the production enviroment. 

- In our case, though  the data at present for our project is not substantially large but the main aim of using several technologies and tools here, is to provide the **user-guide** when working with large datasets, which means steps to be followed while extending the prject would essentially be the same.

- hence we wil show here how to use mongodb and elastic search together effectively, that is, puch the data from **mongoDB** instance to **elasticsearch**. Please follow this link to understand how to make connection between mongoDB and elasticsearch. 
