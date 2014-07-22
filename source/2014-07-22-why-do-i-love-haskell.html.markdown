---
title: why do I love Haskell
date: 2014-07-22 22:33 UTC
tags: haskell
layout: post
---

When I started to learn Ruby, I was excited. It was so great and so easy! The code was readable almost as English and the language allowed me to do everything I wanted. Well, Rails was a bit magical for me, but it was also a very effective. Maybe I did not exactly know why, but it worked and I was able to build an application. 

Here am I, two years later, and I still love doing in Ruby. I have a job
as a Rails developer, I am learning it in my University ... It is
basically all I know, but...I slowly start to feel the downsides of this
freedom I was so excited about. And I realize it even more and more as I
am learning functional programming with Haskell.

 I just finished the notorous Learn You a Haskell for a Great Good book,
which I got from my boyfriend. First, I read it just because I was
curious but then I realize that I really love what I am reading. It was
not like learning Ruby at all, it was like learning how to program all
over again! I discovered that nothing what I already knew will help me,
but it was OK, I was doing it for fun. Then I discovered that there is a
certain security, which evryone is talking about and which is actually
pretty awesome. Then I discovered math in Haskell and I started to
understand it much better, and lastly I discovered how beautifly everything goes together. But
step by step.

## Haskell is not like any other programming language, or at least not like Ruby.
Haskell syntax is very simple. I do not understand why would anyone say
something else. There are just functions which given the same input
always return the same output. Every function should have a type
declaration in the first line, because Haskell is statically typed.

```haskell
factorial :: Integer -> Integer
factorial n = product [1..n]
```

Haskell is lazy, which means that a function argument will not get
evaluated until it has to be. This allows us to work with infinite
lists, which I think is really cool :) Now you can start to see how
different Haskell is from Ruby, but it may not be clear why are these
things good. Lets continue.

Haskell uses pattern matching. In your function, you can implement it
several times for different patterns and the one which will match will
be called.

```haskell
reverse :: [a] -> [a]
reverse [] = []
reverse (x:xs) = reverse xs ++ [x]
```

This example is so elegant! If we put an empty list into this function,
the result is also empty list. That is our first patter. The second
patter says, if we put anything else, we can see it as X and XS, he head
and the rest. First element and the other elements. The implementation
is than calling recursively the same function but only for the rest (xs)
and putting the first element to the end of the results. 

It is bery common in Haskell to treat every possible situation which can
occur. It is similar as in Ruby checking if what we got into a
function is not an accidental nil, but is more powerfull because Haskell
will actually tell you if you are not matching all the possible cases!

## Safety with types
Yes, Haskell is lazy, it is pure and it has cool pattern matching but
the biggest difference from Ruby and the thing I love the most is its
type system. As I said, it is statically typed, so all the types of your
functions and arguments are checked before it is compiled. If the
compilation suceeds, your code is most probably correct! What a nice
feature to have, I wish someone would tell me if my Ruby code is correct
the same way ... 

Well, someone could say, that to type the types on every variables and
every function is tedious and can get you in the way. But not in
Haskell! You do not have to explicitely write the types, the compiler
can reason about them. Which is nice because it can also tell you when
you are not sure. 

The best of all is making your own type classes though. Have you ever
made a function in Ruby which was expecting for example an User ID but
you accidently send an Report ID instead and was wondering what went
wrong? With Haskell you could do a type just for User ID and check if it
is passed in. Integers are not all the same!

You can make type classes which supports some behaviour and then
concrete instances of these classes. For example:

```haskell
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool
```

Here Eq is a class for things that can be compared if they are equal.
Lots of things can do that, so the instances of this class could be
Integers, Strings, etc ... The function type declaration says that for
equal (==), the function takes two things of the same type (a) and
return a Bool - true or false. For not equal it is the same. 





