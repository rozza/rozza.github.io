+++
Categories = ["scala", "mongodb", "spark", "BigData", "jvm"]
Description = "The new MongoDB Spark connector has been released!"
Tags = ["scala", "mongodb", "spark", "bigdata"]
date = "2016-06-27T22:10:30+01:00"
title = "MongoDB Scala Connector Released"
+++

<img style="max-width: 100%;" src="/images/sparks.jpg">

The new MongoDB Spark connector has been released!  

Last month I [announced]({{< relref "introducing-a-new=mongodb-spark-connector.md" >}})
 that the new Spark connector for [MongoDB](http://mongodb.org) was in beta. After some invaluable
 testing by the community, I'm excited to announce that the first official release is now available from 
 [spark-packages](https://spark-packages.org/package/mongodb/mongo-spark):

 ~~~shell
> $SPARK_HOME/bin/spark-shell --packages org.mongodb.spark:mongo-spark-connector_2.10:1.0.0
 ~~~

## A clean, simple connector.
At [MongoDB](http://mongodb.org/) we've been listening to your feedback about what you would like from a new mongodb connector. 
With that in mind we've written a totally new idiomatic connector for spark:
<!--more-->

~~~scala
import com.mongodb.spark._
import com.mongodb.spark.sql._

// Loading data is simple:
val rdd = sc.loadFromMongoDB()     // Uses the SparkConf for configuration
println(rdd.count)
println(rdd.first.toJson)

// DataFrames and DataSets made simple:
// Infers the schema (samples the collection)
val df = sqlContext.loadFromMongoDB().toDF()
df.filter(df("age") < 100).show()  // Passes filter to MongoDB

// Schema provided via a Case Class
val dataframeExplicit = sqlContext.loadFromMongoDB().toDF[Character]()
val dataSet = sqlContext.loadFromMongoDB().toDS[Character]()

// Writing data to MongoDB is also easy:
val centenarians = sqlContext.sql("SELECT name, age FROM characters WHERE age >= 100")
centenarians.write.option("collection", "hundredClub").mongo()
~~~

More examples and full documentation can be found on the [documentation](https://docs.mongodb.com/spark-connector/) site.

## Feedback wanted

We would love to have your feedback on the new driver, so please feel free to post to the [MongoDB User](https://groups.google.com/forum/#!forum/mongodb-user) mailing list or 
add feature requests to the [Jira project](https://jira.mongodb.org/browse/SPARK/).

Enjoy!
