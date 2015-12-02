# Kibana is served by a back end server. This controls which port to use.
# server.port: 5601

# The host to bind the server to.
# server.host: "0.0.0.0"

# The Elasticsearch instance to use for all your queries.
# elasticsearch.url: "http://localhost:9200"

# preserve_elasticsearch_host true will send the hostname specified in `elasticsearch`. If you set it to false,
# then the host you use to connect to *this* Kibana instance will be sent.
# elasticsearch.preserveHost: true

# Kibana uses an index in Elasticsearch to store saved searches, visualizations
# and dashboards. It will create a new index if it doesn't already exist.
# kibana.index: ".kibana"

# The default application to load.
# kibana.defaultAppId: "discover"

# If your Elasticsearch is protected with basic auth, this is the user credentials
# used by the Kibana server to perform maintenance on the kibana_index at startup. Your Kibana
# users will still need to authenticate with Elasticsearch (which is proxied through
# the Kibana server)
# elasticsearch.username: user
# elasticsearch.password: pass

# SSL for outgoing requests from the Kibana Server to the browser (PEM formatted)
# server.ssl.cert: /path/to/your/server.crt
# server.ssl.key: /path/to/your/server.key

# Optional setting to validate that your Elasticsearch backend uses the same key files (PEM formatted)
# elasticsearch.ssl.cert: /path/to/your/client.crt
# elasticsearch.ssl.key: /path/to/your/client.key

# If you need to provide a CA certificate for your Elasticsearch instance, put
# the path of the pem file here.
# elasticsearch.ssl.ca: /path/to/your/CA.pem

# Set to false to have a complete disregard for the validity of the SSL
# certificate.
# elasticsearch.ssl.verify: true

# Time in milliseconds to wait for elasticsearch to respond to pings, defaults to
# request_timeout setting
# elasticsearch.pingTimeout: 1500

# Time in milliseconds to wait for responses from the back end or elasticsearch.
# This must be > 0
# elasticsearch.requestTimeout: 300000

# Time in milliseconds for Elasticsearch to wait for responses from shards.
# Set to 0 to disable.
# elasticsearch.shardTimeout: 0

# Time in milliseconds to wait for Elasticsearch at Kibana startup before retrying
# elasticsearch.startupTimeout: 5000

# Set the path to where you would like the process id file to be created.
# pid.file: /var/run/kibana.pid

# If you would like to send the log output to a file you can set the path below.
# logging.dest: stdout

# Set this to true to suppress all logging output.
# logging.silent: false

# Set this to true to suppress all logging output except for error messages.
# logging.quiet: false

# Set this to true to log all events, including system usage information and all requests.
# logging.verbose



# soccer-analytics-with-python-mongoDB-elasticsearch-kibana-marvel-R
Using **Python**, **NoSQL** (`mongoDB` & `elasticsearch`) and **R** for pipeline structure

- The project is On-going... and would be updated here accordingly.

This project is an idea put at work on pipe-lining individual tools/languages and skills for extracting the maximum capabilities of each of them. The languages used are `Python`, `NoSQl`, and `R` programming. 

> As we know *Python* is primarily a scripting language that is highly proficient with data extraction, manipulation and web development. Here we use it for capturing structured and unstructured data from the web and aligning it to a specific format that is easy to work with. This structured data is then forwarded to the NoSQL database connection with *mongoDB* for data management and updating as and when required. This data is communicated to *elasticsearch* which provides the defualt indexing to help searching the data faster. This data then further follows with *R* programming, by connecting the database from the other end to create a virtual pipeline flow. The data thus imported into R, would be used for performing explanatory data analysis and predictions, ranging from both descriptive data analysis to prescriptive analysis with focus on obtaining the summary statistics from multiple variables (principal variables) and applying the efficient and apt models after testing for accuracy. 

`Pipelining BigData tools for the future ready & better Data Sciences`

![python](https://camo.githubusercontent.com/75df843251780da1799006ef66b44ac702bf901d/68747470733a2f2f7777772e707974686f6e2e6f72672f7374617469632f636f6d6d756e6974795f6c6f676f732f707974686f6e2d6c6f676f2d6d61737465722d76332d544d2e706e673f7261773d74727565 "python") **+**  ![mongoDB](https://camo.githubusercontent.com/c6d1f7e30e97751f865b77b85ea756a0ebc13714/687474703a2f2f69302e77702e636f6d2f69736374652e61636d2e6f72672f77702d636f6e74656e742f75706c6f6164732f323031352f30322f6d6f6e676f64622d6c6f676f312e706e673f726573697a653d3634302532433231333f7261773d74727565 "mongoDB") **+** ![elk](https://raw.githubusercontent.com/blacktop/docker-elk/master/docs/elk-logo.png?raw=true "elk")
**+** 
![R](https://camo.githubusercontent.com/a6ce64d0ce60f9fc16501f343e9f086d1a01e7df/68747470733a2f2f646576656c6f7065722e722d70726f6a6563742e6f72672f4c6f676f2f526c6f676f2d332e706e673f7261773d74727565 "R")








## The end goals considered for this project are finding: 


**The top scorers by the end of the season**


**The top teams most likely to make it to Top 4 spots and qualify for Champions league and Europa league.**

- The teams data selected for this purpose is restricted to Laliga, which is the Spanish competition between 20 Division-I teams. Shiny web development (which is an integration with R software provides excellent highly resourceful visualization for the end results as well for reporting, and hence would also be incorporated with it)

Datasource- [Spanish_Team_Data](http://www.football-data.co.uk/spainm.php)
