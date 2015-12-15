# mongoDb connection with elasticsearch.


#### From what we have done up till now, we have scraped the web page for the desired data, and have transferred it to the mongoDB database management system, where it is stored currently. 

> There are two options to move ahead after this. 

- **First**, connect the data directly from mongoDB to R programming system , that is, `R Studio`, however the problem with this is, the packages `Rmongo` and `rmongodb` have been deprecated for the newer current version of *mongoDB* database, colution to which would be to choose from the `archive` list of download page (mongoDb), the older version that is compatible with the packages offered by R. However, doing so, we lose significant improvements that have been brought in newer versions.

- **Second**, and the preferred way of getting around this deficit would be to utilize the power of `elasticsearch` with `mongoDB` combined. Here we will describe how to use two NoSQL systems together and transfer data from one source to another, which would finally deposit it in R.


# Introduction.

The main purpose of transporting data from mongoDB to elasticsearch is to be able to `index` the document, which is fastly done in `es`, and feed in to R for analysis and modelling. In order to achieve our goal of connecting mongoDB with elasticsearch we need to be able to create a replica set for `master` set, running on master port, i.e., the port (`27017`) to which we transferred our data from python. 

### Purpose of replica set.

The main purpose of a replica set is to provide redundancy for your data. Any data you write is replicated among all members of the set, so if a member of your set goes down you can keep operating. I have personally had two production systems saved by the fact that I was using a replica set – the system never went down even though I lost a server (and in one case lost two at the same time).

A replica set is always going to be deployed across different cloud instances, and often in different data centers, or even across different cloud providers in order to enhance reliability. For this tutorial, however, we are going to run all of our instances on our local machine, just to make things a little easier. In our case, we are going to run instances on different ports, and with different data directories.

From MongoDB's perspective, they will behave almost exactly the same as if we ran them on different servers. The main difference is that replication, recovery, and general communication between the servers on a local machine will be faster because there is less latency. The core operations will be identical, though.

If you have access to multiple cloud servers through your cloud provider, you should be able to follow the tutorial using cloud servers instead of your local machine and it will work the same way.

# Starting the mongoDb server

We are going to be creating a lot of windows for this tutorial, to simulate different machines. I've labeled my examples so you know which window is which, but you will want to keep them organized on your desktop.

- Start by creating 3 data directories off of your MongoDB directory (or somewhere else if you prefer):

`C:\MongoDB>md data1 `  #this would be the primary data store directory (or either one of the three)
`C:\MongoDB>md data2 ` 
`C:\MongoDB>md data3 `

- Start an instance of MongoDB like this:

`C:\MongoDB>bin\mongod --dbpath data1 --port 27017  `

- Open another command prompt. We will use this window to query our first instance.

`C:\MongoDB>bin\mongo --port 27017` 

```
MongoDB shell version: 3.0.5  
connecting to: 127.0.0.1:27017/test 
```

**Remember** :
This above mongodb instance on data1 needs to run before we transfer the data from python `pymongo`. So now we are connected to our MongoDB server running on port 27017. we insert the document like previously.

# Starting Replication

- Now kill your MongoDB instance and restart it this way:

`C:\MongoDB>bin\mongod --dbpath data1 --port 27017 --replSet mySet`

That tells MongoDB that it is part of a replica set. Go back to your command window. Kill the connection and reconnect.

Go to your command window: Start mongo shell like before and run following command.

> rs.initiate() 

```
{
  "info2" : "no configuration explicitly specified -- making one",
  "me" : "Neeraj:27021",
  "ok" : 1
}

mySet:OTHER>  
```


Note that command prompt has changed to show we are part of set now, and it says "OTHER"
On this, query the document stored, in our case, `spainsoccer` db and `liga_data` the collection.
So, `db.liga_data.find()`

Our query works, and now the command prompt now says "PRIMARY" because the replication magic has decided that we are now the master. This is important to know. If all of your replication members die but one, you can still keep operating.

Next, we will run the command that you will run the most often in relations to replica sets - rs.status;
```
Run:
mySet:PRIMARY> `rs.status()`
```

# Adding replica members now.

Open 2 more command prompt windows and start 2 new instances of MongoDB like this:
```
`C:\MongoDB>bin\mongod --dbpath data2 --port 27018 --replSet mySet  `

`C:\MongoDB>bin\mongod --dbpath data3 --port 27020 --replSet mySet  `
```

This is effectively the same thing as running MongoDB on three machines, since we have three different data directories and three different ports.

So we have three servers now, all ready to be part of a replica set, but only one of those is actually part of it. You force the other ones to join by issuing commands on the master.
Go back to the master mongo shell above and run following:

```
mySet:PRIMARY> rs.add('Neeraj:27018')  

{ "ok" : 1 }
```

The reason we have to do this is that MongoDB is picky about using multiple 'localhost' names in a replica set. That won't be an issue in a real deployment. Now if you run rs.status you will see the new member markes as `Secondary` which means first replica has been made for theport `27017`.

Open up a new query window so we can see:
mongo shell for the secondary set member.

`C:\MongoDB>bin\mongo --port 27018  `
```
MongoDB shell version: 3.0.5  
connecting to: 127.0.0.1:27018/test  
mySet:SECONDARY> db.use() # to use the databse we have created already and then db.liga_data.find()
```

Notice above command would give **error**, because mongodbreally wants us to stick to the master. We can get around that, though:
```
run this :
`mySet:SECONDARY> rs.slaveOk() `
```

This makes our secondary set `27018` ready to share the data from master and We told MongoDB that we are ok with querying slaves. 

Again go back to the primary mongo shell of 27017 port, the master and run following:

```
mySet:PRIMARY> rs.add('Neeraj:27020') #add another member .
and again open the secondary shell for port `27020`,a nd run slavOk() command.
```

Now we have 3 replica sets running on primary port shared by secondary ports. 

> You always want to have an odd number of replica set members because they vote on who is the primary. Bad things can happen with even numbers.


Now why did we choose port `27017` as primary port, in particular?


### replicating mongo with elastic

```
We want to be able to connect mongoDb to elasticsearch and we would utilize the `mongo connector` for that purpose. 
```

####Installation

The easiest way to install mongo-connector is with pip:

```
pip install mongo-connector
```

You can also install the development version of mongo-connector manually:

```
git clone https://github.com/10gen-labs/mongo-connector.git
cd mongo-connector
python setup.py install
```


> After installing mongo connector for elastic search use following codes to make the connection.


Mongo Connector can replicate to Elasticsearch using the Elastic DocManager. The most basic usage is the following:

```
mongo-connector -m localhost:27017 -t localhost:9200 -d elastic_doc_manager
```

- we specifically use therefore, localhost `27017` for mongodb database. 
- This assumes there is a MongoDB replica set running on port 27017 and that Elasticsearch is running on port 9200 both on the local machine.


old usage (before 2.0 release):

```
mongo-connector -m localhost:27017 -t localhost:9200 -d <your-doc-manager-folder>/elastic_doc_manager.py
```
