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

