+++
Categories = ["java", "mongodb", "nosql", "jvm"]
Description = "MongoDB Java Driver POJOs"
Tags = ["java", "mongodb", "nosql", "jvm"]
date = "2017-08-04T10:10:30+01:00"
title = "MongoDB POJO Support"
+++

I'm really pleased to announce that version 3.5.0 of the [MongoDB Java Driver](http://mongodb.github.io/mongo-java-driver/3.5/) has been released with POJO (Plain Old Java Object) support! 

## Codecs

MongoDB uses [BSON](http://bsonspec.org), a binary super set of JSON, for its wire protocol and storage format. The
3.0 series of the Mongo Java Driver introduced `Codecs` - an improved way of translating these BSON into the native Java  objects eg: `Document` or `BsonDocument`.

Codecs are an abstraction that determine how BSON data is converted and into what type.  As an abstraction, it can be quite verbose to write your own custom POJO Codecs. As each POJO requires a `Codec` implementation to be registered in the `CodecRegistry`. The amount of code required to support an application with tens of POJOs was often seen as a barrier to entry.  

However, the benefits of using Codecs for handling your POJOs were numerous.  It could easily simplify your main application code, as POJOs can map directly to the domain, making the code easier to reason. Another benefit is speed, Codecs can negate the need to use an intermediate map-like object before hyrdating your domain object. For this reason, it has been a long requested feature to make the creation of Codecs from POJOs automatic.

## PojoCodecProvider

<!--more-->

 The mechanims for POJO support is via the `PojoCodecProvider` which provides a builder for configuring how and what POJOs to support. The builder allows registering of classes and packages, there is even a setting that means the provider to automatically try and handle any POJO it sees. The example below will create a `CodecRegistry` that will handle any POJO that meets the Java bean specification:
 
 ```java
import org.bson.codecs.configuration.CodecProvider;
import org.bson.codecs.configuration.CodecRegistry;
import static org.bson.codecs.configuration.CodecRegistries.fromRegistries;
import static org.bson.codecs.configuration.CodecRegistries.fromProviders;

// Create a CodecRegistry containing the PojoCodecProvider instance.
CodecProvider pojoCodecProvider = PojoCodecProvider.builder().automatic(true).build();
CodecRegistry pojoCodecRegistry = fromRegistries(defaultCodecRegistry, fromProviders(pojoCodecProvider));
```

**Note:** When using the automatic setting with `PojoCodecProvider` always ensure that its the last `CodecProvider` or `CodecRegistry`. Otherwise it will try and handle any type it sees that has at least one serializable or deserializable property.
 
## Fun with POJOs

Once you've configured your `CodecRegistry` it can be used when creating a `MongoClient`, a `MongoDatabase` or a `MongoCollection`.  The following example gets a list of all `members` from MongoDB:

```java
MongoDatabase database = mongoClient.getDatabase("members").withCodecRegistry(pojoCodecRegistry);
MongoCollection<Person> collection = database.getCollection("members", Person.class);

List<Person> members = collection.find().into(new ArrayList<Person>());
```

As you can see, using POJOs with MongoDB is super simple! And using the `automatic` setting you can use *any* Java bean!

## Customising POJOs

There are two main ways to customise how POJOs are serialised / deserialised: [Conventions](http://mongodb.github.io/mongo-java-driver/3.5/bson/pojos/#conventions) and ClassModels.   The underlying abstractions used by the `PojoCodecProvider` are ClassModels and PropertyModels.  As ClassModels are complex, its not recommended that users build and create them from scratch, but rather modify them via the Conventions mechanism. 

Conventions are a handy abstraction that take and modify the `ClassModelBuilder` before its made into an immutable `ClassModel`. The default Conventions handle the [default annotations](http://mongodb.github.io/mongo-java-driver/3.5/bson/pojos/#annotations) and have special handling for `id` properties.  Writing a custom `Convention` is trivial so supporting alternative annotations is easy. Conventions can be registered on the `PojoCodecProvider` and they will be run in order they are supplied.

## Available now

POJO support is available now! It includes support for Java beans, as well as abstract classes, interfaces and nested generic types. So please try it out!  

There's loads more information in the [POJO documentation](http://mongodb.github.io/mongo-java-driver/3.5/bson/pojos/) as well as a [quick-start guide](http://mongodb.github.io/mongo-java-driver/3.5/driver/getting-started/quick-start-pojo/) to get you started.

Enjoy!
