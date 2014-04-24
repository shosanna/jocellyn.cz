---
title: Javascript ain't Ruby
date: 2014-03-05 00:00 UTC
tags: programming, javascript, ruby
---

Javascript was my first “programming” language I met. it was a while ago, in times when I was doing my personal blog, playing around with CSS and learning HTML. I wanted to add some extra cool behavior to my blog, so I started javascript class at Codecademy. But I was not using it as a programming language, I had no idea what does it even mean. I saw it just as a dynamic tool to make animations and for that purpose it was great. I was happy I could do stuff sortable lists in jQuery, fading elements away, etc. It was not even hard to type a one line code that could do that.

Ruby was my actual first language I learnt. Well, to be accurate, I first learnt rails, which is also a whole different story, but lets speak about ruby in general. That was a shock! It is really, really hard to learn programming language when you do not even know what is programming, what is web application, what is algorithm or how does internet work. It was a tough half a year, but I made it trough. I got to ruby syntax, ruby way of thinking and also ruby community. I felt in love with this world. I wrote classes, made instances, create methods. I ducktyped, I used polymorphism, I inherited and I enjoyed everything. It was a fabulous feeling when I made a program, which read from a file, processed text based on XML configurations and then wrote into another file. I felt really powerful and amazed - two years ago I would never though you could do something like that with programming, I thought its only about making webpages.

Now, I am learning javascript again, after more than a year. I can see it in whole new light, I am looking at it as it is ruby. After all, they are both object oriented, high level, dynamic languages… But javascript ain’t ruby, not even remotely! And I still struggle with it. One would say, that knowing first programming language, learning another is a simple story. Not for me, I just can not understand so many things.

It gets really confusing even in the beginning. Where are classes?? Where are instances? Ok, I could write a constructor like this:

function Person(name, age) {this.name = name; this.age = age;}

and then create new people like this:

new Person(“Susan”, 24);

But it just doesn’t feel right… I got back a basic hash - Person {name: "Susan", age: 24}, in ruby I would got an object, encapsulated real object, which I can control if its attributes could be set and get. Not like in js where I can just type Person.someRandomProperty and set it just out of the blue. I miss any structure here. I can’t shake down the conviction that there should be basic data structures like arrays and hashes and then there should be an instance of a class, which is neither of it.

Another weirdness, why should function be a blueprint for instances? Function should be a method, some action which the object can do. But functions in javascript could be many things apparently. You can nest functions together as you would define methods on an class, what a nice think to do!! But do not forget about this. “This” will mean a different things depends on which level of your nested nightmare you are currently on, but since “this” is the only way to point to the instance, you need to save it into a variable first. How clever.

Ruby is saint. Everything in ruby makes sense to me. Functions are functions, classes are classes. I would like to get into javascript, to know its “good parts” but so far, its just a bit chaotic for me. I am worried I will see it only as a browser-beautifuler and cool-stuff maker and never actually use it to do some real stuff. Currently I am working on a pomodoro browser timer. Purely in javascript. Wish me luck so I can finish it and hopefully maybe appreciate javascript as a programming language.