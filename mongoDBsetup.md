## How to download, install and get mongoDB up and running.

### Introduction.

> What is NoSQL?

- NoSQL encompasses a wide variety of different database technologies that were developed in response to a rise in the volume 
of data stored about users, objects and products, the frequency in which this data is accessed, and performance and processing 
needs. Relational databases, on the other hand, were not designed to cope with the scale and agility challenges that face 
modern applications, nor were they built to take advantage of the cheap storage and processing power available today.

> NoSQL Database Types

- Document databases pair each key with a complex data structure known as a document. Documents can contain many different 
key-value pairs, or key-array pairs, or even nested documents.
- Graph stores are used to store information about networks, such as social connections. Graph stores include Neo4J and 
HyperGraphDB.
- Key-value stores are the simplest NoSQL databases. Every single item in the database is stored as an attribute name 
(or "key"), together with its value. Examples of key-value stores are Riak and Voldemort. Some key-value stores, 
such as Redis, allow each value to have a type, such as "integer", which adds functionality.
- Wide-column stores such as Cassandra and HBase are optimized for queries over large datasets, and store columns of data 
together, instead of rows.

> What is mongoDB?

- MongoDB stores data as **documents** in a binary representation called BSON (Binary JSON). Documents that share a similar 
structure are typically organized as collections. You can think of collections as being analogous to a table in a relational 
database: documents are similar to rows, and fields are similar to columns.

- MongoDB documents tend to have all data for a given record in a single document, whereas in a relational database 
information for a given record is usually spread across many tables.

- For example, consider the data model for a blogging application. In a relational database, the data model would comprise 
multiple tables such as Categories, Tags, Users, Comments and Articles. In MongoDB the data could be modeled as two 
collections, one for users, and the other for articles. In each blog document there might be multiple comments, multiple 
tags, and multiple categories, each expressed as an embedded array.

`Source` : [Official webpage](https://www.mongodb.com/)

[https://www.mongodb.com/assets/products/Nexus_Architecture_Grey_Labels-f343b771c2595f327b7c10d4a532bbfca2f55ee67425741cc63fb9073d76e4a3.png](https://www.mongodb.com/assets/products/Nexus_Architecture_Grey_Labels-f343b771c2595f327b7c10d4a532bbfca2f55ee67425741cc63fb9073d76e4a3.png?raw=true)

### Download and Install mongoDB

- Go to the [The mongoDb download page](https://www.mongodb.org/downloads?_ga=1.192214248.339442226.1446671659#production)
- Select the Operating system of your choice (the one you are working on), and download it on your sysytem. Double click the `.msi` file in the folder and run it.
- Go to the *bin* sub-directory of the folder and in your command prompt, run `mongod.exe`
- mongoDB would run on localhost(we can provide custom localhost, here we will use (`localhost:27017`, while exporting datato mongoDB) now and is ready for inserting documents into it.


### Inserting documents into mongoDB database.

- there are many ways you could push your data into mongoDB, one of the them is to use `mongo shell` annd write commands on prompt, however this is usually not recommended. MongoDB provides several different  `drivers` that allows easier and better approach to inserting documents into the databse, one of the popular driver, we are going to use in our project is **python driver**, with `pymongo` module. Please refer to this page to this how to easily insert our data into mongoDB in few steps. [pymongo driver](https://github.com/neerajnj10/soccer-analytics-with-python-mongoDB-and-R/blob/master/first.py)
