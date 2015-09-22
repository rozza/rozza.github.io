+++
Categories = ["scala", "mongodb", "reactive", "tech", "jvm"]
Description = "Introducing the new MongoDB Scala Driver"
Tags = ["scala", "mongodb", "reactive"]
date = "2015-09-22T16:29:52+01:00"
title = "Introducing a new MongoDB Scala Driver"
+++

I'm really pleased to announce the first release candidate of a new MongoDB Scala Driver!

<img style="float:right;" src="http://mongodb.github.io/mongo-scala-driver/s/img/mongoScalaLogo.png">


## Insider information
At [MongoDB](http://mongodb.org/) we've been really busy, back in April we [introduced](https://www.mongodb.com/blog/post/introducing-30-java-driver) the 3.0 Java driver. It was a massive undertaking that included numerous improvements and updates. What got me most excited with the 3.0 release was the introduction of a new fully asynchronous, non-blocking driver. Using this asynchronous driver as a base we also released an [RxJava](mongodb.github.io/mongo-java-driver-rx) driver and a [Reactive Streams](http://mongodb.github.io/mongo-java-driver-reactivestreams) driver.

Today we are announcing a new MongoDB Scala Driver, which also builds upon the asynchronous driver, whilst still providing a first class Scala experience.

## Scala specifics

This new Scala driver required much more than a simple wrapping of the Java driver. A core requirement was it had to meet modern Scala idioms. Below are some of the headline new features:

  * A modern idiomatic Scala driver
  * Fully asynchronous, with non-blocking IO.
  * A new [`Observable`](http://mongodb.github.io/mongo-scala-driver/1.0/reference/observables/) type that is both composable and flexible for handling streams of data from MongoDB.
  * A new type safe [`Document`](http://mongodb.github.io/mongo-scala-driver/1.0/bson/documents/) class with the convenience of a `Map` (thanks to a closed generic algebraic data type).
  * A clean modern API following the latest MongoDB driver [specifications](https://github.com/mongodb/specifications).
  * A new namespace for Scala `org.mongodb.scala`
  * Comprehensive [documentation](http://mongodb.github.io/mongo-scala-driver/) site to help get you started.

## Feedback wanted

We would love to have your feedback on the new driver. Please feel free to email me directly or post to the [MongoDB User](https://groups.google.com/forum/#!forum/mongodb-user) mailing list.

The best place to start and get up and running with the new driver is the [getting started](http://mongodb.github.io/mongo-scala-driver/1.0/getting-started/) guide.
