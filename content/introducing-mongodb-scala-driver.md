+++
Categories = ["scala", "mongodb", "reactive", "tech", "jvm"]
Description = "Introducing the new MongoDB Scala Driver"
Tags = ["scala", "mongodb", "reactive"]
date = "2015-09-23T13:00:00+01:00"
title = "Introducing a new MongoDB Scala Driver"
+++

I'm really pleased to announce the first release candidate of a new MongoDB Scala Driver!

<img style="float:right;" src="http://mongodb.github.io/mongo-scala-driver/s/img/mongoScalaLogo.png">


## Insider information
At [MongoDB](http://mongodb.org/) we've been really busy, back in April we [introduced](https://www.mongodb.com/blog/post/introducing-30-java-driver) the 3.0 Java driver. It was a massive undertaking that included numerous improvements and updates. What got me most excited with the 3.0 release was the introduction of a new fully asynchronous, non-blocking driver. Using this asynchronous driver as a base we also released an [RxJava](mongodb.github.io/mongo-java-driver-rx) driver and a [Reactive Streams](http://mongodb.github.io/mongo-java-driver-reactivestreams) driver.

Today we are announcing a new MongoDB Scala Driver, which also builds upon the asynchronous driver, whilst still providing a first class Scala experience.

## Scala specifics

 This new Scala driver required much more than a simple wrapping of the Java driver. Here are some of the highlights:

  * A modern idiomatic Scala driver with asynchronous and non-blocking IO.
  * A new [`Observable`](http://mongodb.github.io/mongo-scala-driver/1.0/reference/observables/) type that is both composable and flexible enough to handle streams of data from MongoDB.
  * New immutable and mutable type safe [`Document`](http://mongodb.github.io/mongo-scala-driver/1.0/bson/documents/) classes with all the convenience of a `Map`.
  * A clean modern API following the latest MongoDB driver [specifications](https://github.com/mongodb/specifications).
  * A new namespace for Scala `org.mongodb.scala`. No more confusion about what classes required for the Scala driver.
  * Comprehensive [documentation](http://mongodb.github.io/mongo-scala-driver/) site to help get you started.
  * Easy [integration](http://mongodb.github.io/mongo-scala-driver/1.0/integrations/) with other Reactive libraries such as [RxScala](http://reactivex.io/rxscala/) and [Reactive Streams](http://www.reactive-streams.org/).

Below is a quick example to whet your appetite:

~~~scala
// Connect to the users collection in mydb
val mongoClient: MongoClient = MongoClient()
val database: MongoDatabase = mongoClient.getDatabase("mydb")
val collection: MongoCollection[Document] = database.getCollection("users")

// The Document ADT enforces type safety and can implicitly box native scala types to BSON types
val query = Document("user" -> "Martin")  // "Martin" becomes BsonString("Martin")

// Lets run a query for all Martins and print out the json representation of each document
collection.find(query).subscribe(
  (user: Document) => println(user.toJson()),                         // onNext
  (error: Throwable) => println("Query failed: ${error.getMessage}"), // onError
  () => println("Done")                                               // onComplete
)

// Want Futures? No problems!
val futureUsers: Future[Seq[Document]] = collection.find(query).toFuture()
~~~

Available on sonatype for Scala 2.11:

~~~scala
"org.mongodb.scala" %% "mongodb-scala-driver" % "1.0.0-rc0"
~~~

## Feedback wanted

We would love to have your feedback on the new driver, so please feel free to email me directly or post to the [MongoDB User](https://groups.google.com/forum/#!forum/mongodb-user) mailing list.

The best place to get up and running with the new driver is the [getting started](http://mongodb.github.io/mongo-scala-driver/1.0/getting-started/) guide.
