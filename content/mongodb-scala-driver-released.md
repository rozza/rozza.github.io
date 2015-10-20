+++
Categories = ["scala", "mongodb", "reactive", "tech", "jvm"]
Description = "A new idiomatic MongoDB Driver for Scala"
Tags = ["scala", "mongodb", "reactive"]
date = "2015-10-20T13:10:30+01:00"
title = "MongoDB Scala Driver Released"
+++

<img style="max-width: 100%;" src="/images/starNebula.jpg">

The new Scala Driver for MongoDB has been released!  

Last month I [announced]({{< relref "introducing-mongodb-scala-driver.md" >}})
 the first release candidate of a new idiomatic Scala Driver for [MongoDB](http://mongodb.org) and I'm excited to announce that the first official release is now available on sonatype for Scala 2.11:

 ~~~scala
 "org.mongodb.scala" %% "mongo-scala-driver" % "1.0.0"
 ~~~

## A clean, simple Scala driver.
At [MongoDB](http://mongodb.org/) we've been listening to your feedback about what you would like from a new Scala driver. With that in mind we've written a totally new Scala driver.  Here are some of the highlights:

<img style="float:right;" src="http://mongodb.github.io/mongo-scala-driver/s/img/mongoScalaLogo.png">


  * A modern idiomatic Scala driver with asynchronous and non-blocking IO.
  * A clean modern API following the latest MongoDB driver [specifications](https://github.com/mongodb/specifications).
  * A new namespace for Scala `org.mongodb.scala`. No more confusion about what classes required for Scala.
  * A new [`Observable`](http://mongodb.github.io/mongo-scala-driver/1.0/reference/observables/) type that is both composable and flexible enough to handle streams of data from MongoDB.
  * New immutable and mutable type safe [`Document`](http://mongodb.github.io/mongo-scala-driver/1.0/bson/documents/) classes with all the convenience of a `Map`.
  * Comprehensive [documentation](http://mongodb.github.io/mongo-scala-driver/) site to help get you started.
  * Easy [integration](http://mongodb.github.io/mongo-scala-driver/1.0/integrations/) with other Reactive libraries such as [RxScala](http://reactivex.io/rxscala/) and [Reactive Streams](http://www.reactive-streams.org/).

Below is a quick example to whet your appetite:

~~~scala
// Connect to the users collection in mydb
val mongoClient: MongoClient = MongoClient()
val database: MongoDatabase = mongoClient.getDatabase("mydb")
val collection: MongoCollection[Document] = database.getCollection("users")

// The Document ADT enforces type safety and can implicitly box native scala types to BSON types
val martin = Document("user" -> "Martin")  // "Martin" becomes BsonString("Martin")

// Alternatively, create Documents from Json
val query = Document("""{user: "Martin"}""")

// Lets run a query for all Martins and print out the json representation of each document
collection.find(query).subscribe(
  (user: Document) => println(user.toJson()),                         // onNext
  (error: Throwable) => println(s"Query failed: ${error.getMessage}"), // onError
  () => println("Done")                                               // onComplete
)

// Want Futures? No problems!
val futureUsers: Future[Seq[Document]] = collection.find(query).toFuture()
val firstMartin: Future[Document] = collection.find(query).first().head()
~~~

More examples and full documentation can be found on the [documentation](http://mongodb.github.io/mongo-scala-driver) hub, including a full [getting started](http://mongodb.github.io/mongo-scala-driver/1.0/getting-started/) guide.

## Feedback wanted

We would love to have your feedback on the new driver, so please feel free to post to the [MongoDB User](https://groups.google.com/forum/#!forum/mongodb-user) mailing list or add feature requests to the [Jira project](https://jira.mongodb.org/browse/SCALA/). There are a number of items on the roadmap such as; MongoDB Server 3.2 and Case Class support but all feature requests are welcome.

Enjoy!
