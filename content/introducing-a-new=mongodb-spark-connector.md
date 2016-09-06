+++
Categories = ["mongodb", "spark", "scala", "python", "R", "jvm"]
Description = "Introducing a new MongoDB Spark Connector"
Tags = ["mongodb", "spark", "scala", "jvm"]
date = "2016-05-18T13:43:25+01:00"
title = "Introducing a new MongoDB Spark Connector"
+++

## Update!

The MongoDB Spark connector has been [released]({{< relref "mongodb-spark-connector-released.md" >}})! See the official 
[documentation](https://docs.mongodb.com/spark-connector/) for more information on getting started!

----


Following on from the [official announcement](https://www.mongodb.com/blog/post/mongodb-connector-for-apache-spark-announcing-early-access-program-and-new-spark-training) yesterday, I'm really excited to write a few words about new **MongoDB Spark Connector**.

## Getting started
Before I go into detail about the hows and whys, first have a look at a quick usage example:
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

The MongoDB Spark Connector supports Spark 1.6.1 and Scala 2.10 or 2.11. You can download it from Sonatype with these coordinates:

~~~scala
"org.mongodb.spark" %% "mongo-spark-connector" % "0.2"
~~~

## Backstory
Since January writing a new shiny Spark Connector designed from the ground up. Having initially played with Spark during one of our Skunkworks days over a year ago, I knew we could make a great connector to combine these two wonderful technologies. Last summer we welcomed Marko Vojvodic to the JVM team and during his internship he worked on prototyping a connector in Java. Marko looked at some of the hard problems when writing a great connector; type cohersion, data partitioning and data locality to name a few.

We have a few JVM projects keeping us busy at [MongoDB](http://www.mongodb.com), but in January I got time to start focusing on building the Spark connector. I started with Scala and ported some of Marko's code, wrote new code and built a new API from the ground up.

In April we quietly released the first beta version and solicited feedback from a select group of MongoDB power users. Since then a number of kinks have been ironed out resulting in the 0.2 release. Now we're opening up the beta and asking the wider community for feedback, before we release a 1.0 version.

## Why build a new MongoDB Spark Connector?
I've been asked this a few times, after all the Hadoop connector supports Spark. The reason for a native connector is simple; Spark has quickly grown in popularity and use. It's growth reminds me of MongoDBs and naturally users want to combine both products. So it's only logical to create a *first class experience* and let these users get the most out of combining both technologies.
I really hope we have gone a long way to achieving that with this new connector.

## Language support
The MongoDB Spark Connector supports all the languages Spark supports: Scala, Java, Python and R but under the hood it's written in Scala. This helped keep the API clean because we can make full use of Scala magic like implicits. To keep Java folk happy there's also a special Java API that hides some of the "Scala-ness" such as strange method names from Java users. Hat-tip to the Databricks [Java interoperability](https://github.com/databricks/scala-style-guide#java-interoperability) guide, it's super helpful when considering how to consume a Scala API from Java.

## Feedback wanted!
I hope that has got you interested, I would love to have your feedback on the new connector good or bad. So please feel free to email me directly or post to the [MongoDB User](https://groups.google.com/forum/#!forum/mongodb-user) mailing list. If you are currently using an alternative connector for MongoDB and Spark, I'd **really interested** in any feedback.

The connector is still in Beta, so there maybe changes to the API, but I'm hoping it's stable now. If you do encounter any problems or find a bug please report it by opening an issue at [jira.mongodb.org/browse/SPARK](https://jira.mongodb.org/browse/SPARK).

The quickest way to get up and running with the new connector is via the [introduction](https://github.com/mongodb/mongo-spark/blob/master/doc/0-introduction.md) on github. There is also the [M233: Getting Started with Spark and MongoDB](https://university.mongodb.com/courses/M233/about) course over at the MongoDB University.

Happy Big Data Computing.
