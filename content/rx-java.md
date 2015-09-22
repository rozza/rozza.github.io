---
title: "RxJava - understandably reactive"
date:  "2013-11-06"
comments: true
categories:
- tech
- RxJava
- mongodb
- reactive
- scala
- jvm
aliases:
    - /posts/rx-java/
---

Reactive programing is hot stuff at the moment and the
[Coursera Principles of Reactive Programming](https://www.coursera.org/course/reactive)
course has **just** started (its not too late to enroll).

Recently, I've been hearing good things about [RxJava](https://github.com/Netflix/RxJava) (
a port of .Net's [Reactive extensions](http://msdn.microsoft.com/en-gb/data/gg577609.aspx)
) so I wanted to learn some more. Then I stumbled upon a video from a recent
[SF Scala](http://www.meetup.com/SF-Scala/) meetup
which covered what it is and how they implemented the core and then added
support for other JVM languages.

<!--more-->

Two things immediately struck me:

1. Observables are not opnionated about how the backend works.  It could be
  concurrent or swapped out with a thread pool, an actor
  or an nio event & event loop... Pretty cool, this means there is a single way
  of handling the code no matter if the backend is synchronus or asynchronus.

1. The methods for manipulating multiple observers, chaining or nesting
  is extremely powerful, yet easy to understand.

I'm really looking forward to using it, to me its an easier abstraction to
understand for handling streams of data and seemly less complex than using Plays
excellent `Iteratee.Concurrent` library.

Enjoy:

{{% youtube tOMK_FYJREw %}}
