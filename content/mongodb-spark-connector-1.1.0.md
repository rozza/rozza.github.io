+++
Categories = ["scala", "mongodb", "spark", "BigData", "jvm"]
Description = "The new MongoDB Spark connector releases!"
Tags = ["scala", "mongodb", "spark", "bigdata"]
date = "2016-09-06T17:10:30+01:00"
title = "MongoDB Scala Connector releases!"
+++

Version 1.1.0 of the [MongoDB Spark connector](https://docs.mongodb.com/spark-connector/) has been released. As well as the 
MongoDB Spark Connector 2.0.0-rc0, bring Spark 2.0 support.

## 1.1.0

This is the first release after the 1.0.0 driver and contains some API improvements and updates based on feedback from users.
Many thanks to all those that have provided feedback either through the MongoDB User [mailing list](https://groups.google.com/forum/#!forum/mongodb-user), 
via  [StackOverflow](stackoverflow.com/questions/tagged/apache-spark+mongodb) or via the [Spark Jira project](https://jira.mongodb.org/browse/SPARK/).

It's been thrilling to get such great feedback and find out about some of the real world scenarios the connector has been used for. One of my
favourites so far has been about how [China Eastern Airlines](https://www.mongodb.com/blog/post/mongodb-and-apache-spark-at-china-eastern-airlines) and how they
use the connector to save time and money.  But wether you're a big or small user of the connector, I'd really appreciate your feedback and comments. It really is central to making this connector
even better and more accessible.

### Improvements in 1.1.0

<!--more-->

  * Saving DataFrames with an `_id` field will updated in place, rather than error.
  * You can now use SQL to `INSERT INTO` a collection.
  * Added support for Spark MapTypes in schemas.
  * IsNotNull filter improved so that it also checks the field exists
  * Added helpers for defining the schemas and querying unsupported MongoDB datatypes.


See the full [changelog](https://github.com/mongodb/mongo-spark/blob/1.x/doc/7-Changelog.md) for detailed information and links to the Jira tickets.

The new 
 ~~~shell
> $SPARK_HOME/bin/spark-shell --packages org.mongodb.spark:mongo-spark-connector_2.10:1.1.0
 ~~~

## Spark 2.0 support

The 2.0.0.rc-0 connector is available from [maven central](http://search.maven.org/#search%7Cga%7C1%7Cg%3A%22org.mongodb.spark%22) and provides support for Spark 2.0, as well as
all the improvements from the 1.1.0 generation of the driver.

There were a few minor API changes required to support Spark 2.0:

  * DataFrame and Dataset are now unified.
    In Scala and Java, DataFrame and Dataset have been unified, i.e. DataFrame is just a type alias for Dataset of Row. 
  * SparkSession
    The new entry point that replaces the old SQLContext and HiveContext for DataFrame and Dataset APIs.

The actual code changes to interact with MongoDB should be minimal and are designed to be as unobtrusive as possible. 

## Feedback wanted

We would love to have your feedback on the connector, so please feel free to post to the [MongoDB User](https://groups.google.com/forum/#!forum/mongodb-user) mailing list or 
add feature requests to the [Jira project](https://jira.mongodb.org/browse/SPARK/).

Enjoy!
