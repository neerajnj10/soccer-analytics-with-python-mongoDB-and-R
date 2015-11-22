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

- MongoDB stores data as documents in a binary representation called BSON (Binary JSON). Documents that share a similar 
structure are typically organized as collections. You can think of collections as being analogous to a table in a relational 
database: documents are similar to rows, and fields are similar to columns.

- MongoDB documents tend to have all data for a given record in a single document, whereas in a relational database 
information for a given record is usually spread across many tables.

- For example, consider the data model for a blogging application. In a relational database, the data model would comprise 
multiple tables such as Categories, Tags, Users, Comments and Articles. In MongoDB the data could be modeled as two 
collections, one for users, and the other for articles. In each blog document there might be multiple comments, multiple 
tags, and multiple categories, each expressed as an embedded array.

