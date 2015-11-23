# mongoDb connection with elasticsearch.


## From what we have done up till now, we have scraped the web page for the desired data, and have transferred it to the mongoDB database management system, where it is stored currently. 

> There are two options to move ahead after this. 

- **First**, connect the data directly from mongoDB to R programming system , that is, `R Studio`, however the problem with this is, the packages `Rmongo` and `rmongodb` have been deprecated for the newer current version of *mongoDB* database, colution to which would be to choose from the `archive` list of download page (mongoDb), the older version that is compatible with the packages offered by R. However, doing so, we lose significant improvements that have been brought in newer versions.

- **Second**, and the preferred way of getting around this deficit would be to utilize the power of `elasticsearch` with `mongoDB` combined. Here we will describe how to use two NoSQL systems together and transfer data from one source to another, which would finally deposit it in R.


# Introduction.

The main purpose of transporting data from mongoDB to elasticsearch is to be able to `index` the document, which is fastly done in `es`, and feed in to R for analysis and modelling. In order to chive our 
