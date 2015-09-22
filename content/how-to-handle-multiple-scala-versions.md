---
title: "How to: Handle multiple Scala versions"
date:  "2014-04-23"
comments: true
categories:
- tech
- mongodb
- library
- scala
- jvm
aliases:
    - /posts/how-to-handle-multiple-scala-versions/
---

I recently upgraded [Casbah](http://mongodb.github.io/casbah/) to support the latest Scala 2.11 release and for the first time when supporting multiple Scala versions I hit a stumbling block.  If you're writing a library that wants to support multiple versions of Scala in a single code base, it's generally easy isn't it? Thankfully, it is as [sbt](http://www.scala-sbt.org/) can do the heavy lifting for you.

## Three steps to success

The sbt documentation covers the basics nicely in their [cross build](http://www.scala-sbt.org/release/docs/Detailed-Topics/Cross-Build.html) documentation.  But what's the path to success?

<!--more-->

1. Choose the Scala's you are going to support.

    Set the `crossScalaVersions` setting in your build file to define the Scala versions you want to support. In Casbah we support: `crossScalaVersions := Seq("2.11.0", "2.10.4", "2.9.3")`

2. Configure libraries

    Here it can get hairy because third party libraries may not support all your favoured scala builds in their latest release.  If they do, then happy days but if not you may have to pick out each library version as needed.  Here is an example from the Casbah build:

        // In the build settings append to the library dependencies
        libraryDependencies <++= scalaVersion (sv => Seq(specs2(sv), scalatime(sv)))

        // Helper method to pattern match against the scala version and return the correct specs version
        def specs2(scalaVersion: String) =
          (scalaVersion match {
            case "2.9.3"   => "org.specs2" %% "specs2" % "1.12.4.1"
            case _ => "org.specs2" %% "specs2" % "2.3.11"
          }) % "test"

    As the latest Specs build `2.3.11` doesn't support Scala 2.9.3 we have to use the older `1.12.4.1` version for 2.9.3.  The downside is we can't yet use some of the nicer newer features of the Specs library in our test suite.

3. Scala version specific code.

    This is the real challenge, what do you do if you need specific code for a specific version of Scala?  Hopefully, you'll never need to but this isn't always the case as I found with Casbah.  We use `BeanInfo` annotation and it lives in `scala.reflection` in Scala 2.9.3 and in `scala.beans` in 2.11.

    So how can we get round this? Luckily, Scala 2.10 gave me a hint as `BeanInfo` had been depreciated in `scala.reflection` but they had mirrored it in a [package object](https://github.com/scala/scala/blob/v2.10.4/src/library/scala/reflect/package.scala#L55-L56). I could use the same trick in Casbah! However, I would need a version for Scala 2.9.3 to point to `scala.reflect.BeanInfo` and a version for 2.10 & 2.11. Then update all the code to point to the scala specific package object.

    As the code would be version specific it couldn't live in the `src/main/scala` directory as it wouldn't compile. So instead I created specific Scala directories in `src/main` like so:

        ./scala
        ./scala_2.9.3  // Scala 2.9.3 specific code
        ./scala_2.10   // Scala 2.10 specific code
        ./scala_2.11   // Scala 2.11 specific code

    As Scala 2.10 & 2.11 point versions will be binary compatible I only need a top level directory for them.  Then alls that's needed is to add these source directories to the build:

        unmanagedSourceDirectories in Compile <+= (sourceDirectory in Compile, scalaBinaryVersion){
          (s, v) => s / ("scala_"+v)
        }

    This adds extra source directories to the compile step and using `scalaBinaryVersion` I get the binary compatible versions (so it's 2.11 for all 2.11 releases but would be 2.9.3, 2.9.2, 2.9.1 for the non compatible point releases from the 2.9 series).

    The fix in Casbah was to simply add a `beans.scala` for the scala specific versions and create a `BeanInfo` type which points to the correct scala package. Problem solved.

Sbt allow you to run any command against multiple versions of Scala. `./sbt +test` will test against all your `crossScalaVersions` of Scala and hopefully confirm the code works as expected.  If I want to test a specific version use a double plus sign and add the version string to the arguments eg: `./sbt ++ 2.9.3 test`.

## Final thoughts

Scala is a relatively fast moving ecosystem with new major releases every 13 months or so.  When I took over Casbah it supported 6 binary incompatible versions of Scala! From 2.8.1 to 2.9.3. Happily, Scala patch versions from 2.10.0 on have become binary compatible making supporting multiple versions of Scala easier.  However, one of the key issues for maintaining a library is to know when to end of life an old Scala version, so to keep the library fresh.

In Casbah supporting the current and last major versions of Scala gives users support for the latest MongoDB version and allows them some flexibility when it comes to updating Scala. Generally, this has been a trouble free process and as shown above problems are solvable in just three easy steps.
