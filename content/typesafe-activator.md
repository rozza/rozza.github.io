---
title: "Typesafe's Activator"
date:  "2013-09-24"
comments: true
categories:
- tech
- play
- mongodb
- reactive
- scala
- jvm
aliases:
    - /posts/typesafe_activator/
---

Yesterday the [Typesafe Activator](http://typesafe.com/blog/announcing-activator-10-create-reactive-apps-in-minutes)
hit 1.0. If you haven't heard about it and use scala or the jvm then take five
minutes and check it out - its worth it.

What is it?
===========

My recommendation alone not enough and you what to know more about it before
installing it?  No problems, let me convince you.

> Typesafe Activator is a local web & command-line tool that helps developers
> get started with the Typesafe Platform.

<!--more-->

Whats that give you?  Basically, a real nice UI in the browser for creating web
applications from templates.  The [templates](http://typesafe.com/activator/templates)
cover "hello world" in scala to using [Akka](http://akka.io), [
Play](http://playframework.com) and [Scala](http://www.scala-lang.org/) to create
modern scalable reactive web sites.

Its quick and easy to get going - I chose the
[Play Reactive Mongo and knockout.js](http://typesafe.com/activator/template/play-mongo-knockout)
template

<p class="text-center">
<img src="/images/activator-loading.png">
</p>

In the background it downloads all the resources you need to create the project
from the template.  Starting a new project is extremely simple and once the
project is loaded you get to use the Web UI in anger.

<p class="text-center">
<img src="/images/activator-orientation.png">
</p>

The tutorial
============

Once loaded, you get the tutorial for this template:

> The world is going reactive
>
> Not long ago, response times in the seconds were considered appropriate. Browser
> refreshes were the norm in web applications. Systems would go down for hours of
> maintenance, or even be rebooted nightly, and this was ok because people only
> expected the systems to be up during business hours..

*Exciting stuff!*  So not only can you code, compile and test your application
all in the browser - there's a tutorial to guide you through the various new
concepts as well.

The reactive mongo tutorial, gets you up and running using creating a reactive
Play web application with a rich front end and scalable backend.  It uses
[Reactive Mongo](http://reactivemongo.org) an asynchronous non blocking scala
mongodb driver for the database.  The play framework for the webserver,
[coffeescript](http://coffeescript.org) and [knockout.js](http://knockoutjs.com)
for the frontend.

The tutorial walks you through how the various parts of the app work together and
links through to the code.  Next it sets tasks to update parts of the app, extending
it and adding functionality.

This quickly, gets you up to speed, so if you are interested in any of the
Typesafe stack then download activator now and you'll be up and running in minutes!
