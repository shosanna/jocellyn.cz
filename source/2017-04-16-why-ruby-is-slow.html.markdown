---
title: Why Ruby is slow?
date: 2017-04-16 20:11 UTC
tags: ruby, programming, performance
layout: post
---

I recently bought a book 'Ruby Performance Optimization' by Alexander Dymo and this showrt article is a result of my enthusiasm over this book.
However I am still at the beginning of reading, so there may be more content comming! :)

So, why Ruby is slow? When it comes to slow code in general, people tend to come to conclusion that algorithmic complexity is here to blame. 
Those of us, who had some kind of complexity class at University, we know it very well, The Big O elephant in the room. However, there may be other issues with your code.

In Ruby, everything is an object. Which is really nice and handy, but it comes with an overhead. There is **extra memory needed to represent data as objects**.
If we look deeper inside Ruby (as is explained in another great book, **Ruby Under Microscope**), we would see that for every object, there is at least a class pointer, pointing to a class of an object, and array of its instance variables. A Class, on the other hand, is a Ruby ibject which also has method definitions, attribute names, superclass pointer and constants table.

The main problem with this is a **slow garbage collector**. Up to the version of 2.1 the garbage collection algoritmus used was 'Mark-And-Sweep', which stops the application while it is doing its job. And that, as you may imagine, is very slow. It also depends on the size of the heap, as it needs to visit every active object during the marking phase, so that it could be sweeped later on.
It was also missing a more efficient strategy of handling differently old and new objects in a form of **generations** - as we now from garabge collection in CLR or JVM.

The biggest improvement came up with Ruby 2.1. and its newer GC which is almost 5 times faster. 

Another issue related to data and memory usage is data structure copying.
If you are working with a larger collection, you should always think about avoiding copying and be **modifying in place instead**.
The same goes for string manipulations. There are a whole bunch of bang methods, which perform what they do on the method receiver - instead of returning a copy.

For strings, take a look at:

```ruby
gsub!, capitalize!, downcase!, upcase!, delete!, reverse!, slice!, ...
```

For arrays and hashes:

```ruby
map!, select!, reject!, ... 
```

You should use those every time you do not explicitely need a copy.

Lets take a look at files now. If you are trying to process a large file and do a simple and straight forward `File.read`, you are loading its whole content into memory!
You should always process files line by line - in that way, the previously proceesed lines can be deallocated from memory when no longer needed. 
Something like:

```ruby
  while line = file.readline
    # do something
  end
```

Lastly - watch your iterators. You should be aware when you see usage of `each` or `map` in your code, because it means iterating over collections in one chunk. Ruby on Rails has a nice method `find_each` for iterating over database records not in once but in batches.That is very convinient and can save a lot of performance problems!
Some of Ruby iterators even creates an extra objects while looping - like for example `each_with_index`. If you use that in a nested loop you may have some serious performace issues.

We should use iterators with caution and delegete most of the searching / filtering / and similar functionality to our databases, if it is possible. There is no need to iterate over every record in memory and do some computations on it when it could be done easily and fast via one database query, like for example PostgreSQL Group By or Max functions.

Read the book **Ruby Performance Optimization** for more and stay tunned for other articles :)

