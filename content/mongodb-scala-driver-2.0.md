+++
Categories = ["scala", "mongodb", "reactive", "tech", "jvm"]
Description = "MongoDB Scala Driver 2.0 released"
Tags = ["scala", "mongodb", "reactive"]
date = "2017-03-31T13:15:28+01:00"
title = "MongoDB Scala Driver 2.0 released"
+++

The 2.0.0 version of the official Scala Driver for MongoDB has been released!

<img style="max-width: 100%;" src="/images/scala.jpg">

## Case Class support

I'm really happy to announce the introduction of case class support, making it much easier to use your domain models with MongoDB. Internally Codecs are used to convert datatypes to and from [BSON](http://bsonspec.org) - the internal data format for MongoDB. The 2.0 release includes a Macro that can create a codecs from case classes.<!--more--> The encoding and decoding the values of each field still uses the codec registry, so any users with custom codecs can still happily use these Macro based codecs.

To show how simple it is we can use the following `Person` case class as an example:

~~~scala
case class Person(_id: ObjectId, firstName: String, lastName: String)
~~~

Notice, the `_id` field, this is a special field in MongoDB because it represents the primary key. It's advisable to include `_id` field in your case classes as it gives access to the primary key. When inserting a BSON document into MongoDB if it doesn't contain the `_id` field one is added automatically. By adding a companion object an `_id` can be automatically generated:

~~~scala
object Person {
  def apply(firstName: String, lastName: String): Person =
    Person(new ObjectId(), firstName, lastName)
}
~~~

Creating a CodecProvider for `Person` is simple:

~~~scala
val personCodecProvider = Macros.createCodecProvider[Person]()
~~~

There is also an implicit helper that will create codec providers for your case classes by just passing in the class eg:

~~~scala
import org.mongodb.scala.bson.codecs.Macros._
import org.mongodb.scala.bson.codecs.DEFAULT_CODEC_REGISTRY
import org.bson.codecs.configuration.CodecRegistries.{fromRegistries, fromProviders}

val codecRegistry = fromRegistries(fromProviders(classOf[Person], classOf[MyOtherCaseClass]), DEFAULT_CODEC_REGISTRY)
~~~

Inserting an instance into MongoDB is simple:

~~~scala
val collection = database.getCollection[Person]("People").withCodecRegistry(codecRegistry)
val person: Person = Person("Ada", "Lovelace")
collection.insertOne(person).results() // results() is the custom blocking implicit used in the quick tour.
~~~

Querying and retrieving `Person` instances is also super simple:

~~~scala
collection.find().printResults() // printResults is the helper also used in the quick tour.
~~~


### Sealed classes and ADTs

Hierarchical class structures are supported via sealed classes. Each subclass is handled specifically by the generated codec, so you only
need create a `CodecProvider` for the parent sealed class. Internally an extra field (`_t`) is stored alongside the data so that
the correct subclass can be hydrated when decoding the data.  Below is an example of a tree like structure containing branch and leaf nodes:

~~~scala
sealed class Tree
case class Branch(b1: Tree, b2: Tree, value: Int) extends Tree
case class Leaf(value: Int) extends Tree

val codecRegistry = fromRegistries( fromProviders(classOf[Tree]), DEFAULT_CODEC_REGISTRY )
~~~

## Breaking changes

The scala driver follows semantic versioning, so the 2.0.0 release indicidates there have been some API breaking changes. However, they really are minimal and shouldn't impact most users of the driver.

The implicit default type for various methods in the `MongoCollection` class in 1.0 was `Document`. This was a bug as they should have been
the same type as the collection itself. For example with `MongoCollection[Person].find()` in 1.0 it would have returned an `Observable[Document]`. This is obviously incorrect and has been fixed in 2.0 to return an `Observable[Person]`. Not many people have been impacted by this as it was only an implicit type and could explicity be declared: `MongoCollection[Person].find[Person]()`.

The other potentially breaking change is the introduction of a `SingleObservable` which represents an `Observable` containing only a single item. The implicit `SingleObservable[T].toFuture()` method returns `Future[T]`, whereas `Observable[T].toFuture()` returns `Future[Seq[T]]`. This may catch some users out however, most users of these single result Observables used the `head()` method to get a single item future, so won't be impacted.

## Changable ExecutionContexts

The other main change is the introduction of the `Observable[T].observeOn(context: ExecutionContext)` implicit. This allows for computation to take place on alternative ExecutionContexts, handy for some long running or computationally heavy Observables.

## Feedback wanted

The 2.0 driver is available from:  `"org.mongodb.scala" %% "mongo-scala-driver" % "2.0.0"`. For more information and examples see the [driver documentation](http://mongodb.github.io/mongo-scala-driver/2.0/).

We would love to have your feedback on the new driver, so please feel free to post to the [MongoDB User](https://groups.google.com/forum/#!forum/mongodb-user) mailing list.  For feature requests or bug reports please use [Jira project](https://jira.mongodb.org/browse/SCALA/).

Enjoy!
