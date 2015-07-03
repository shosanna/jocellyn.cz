---
title: Lazy versus Eager
date: 2015-07-03 20:02 UTC
tags: ruby, programming, haskell
layout: post
---

There are two main strategies when it comes to evaluation of en expression, regardless of programming langue. 
This article explains the difference using Haskell and then discusses it with comparation to Ruby.

Lets start with a very simple example: 

```haskell
  sqrt (2+4)
```

This function counts a square root of an expression `2+4`. It can do it in two ways:

```haskell
-- 1. variant
sqrt (2+4)
= 2+4
= 6
= let x = 6 in x * x
= 6 * 6
= 36

-- 2. variant
sqrt (2+4)
= let x = (2 + 4) in x * x 
= let x = 6 in x * x
= 6 * 6
= 36
```
In the first variant, the argument is evaluated first. Only when all arguments
are evaluated, the actual function call (in this case sqrt) is invoked.  This
is called **eager** evaluation.

Second variant was different - the function was invoked first and the
unevaluated arguments (in this case (2+4) was passed to it. Only when the
function needed these arguments they were eventually evaluated.  This is
**lazy** evaluation.

Lets see one more example:

```haskell
fst ((3+2), sqrt 5)

-- 1.variant (eager)
= fst ((5), sqrt 5)
= fst ((5), 5 * 5)
= fst ((5), 25)
= (5)

-- 2.variant (lazy)
= let p = ((3+2), sqrt 5) in fst p
= (3+2)
= (5)
```

We can see the power of lazy evaluation. The second part of the tuple (`sqrt 5`)
 was never needed and thus never evaluated. Lazy evaluation is called lazy
because it never does anything just in case. It postpone the evaluation to the very last moment.

In the eager version, because every argument is evaluated in front, the
calculation of sqrt was done even though it was immidiately discared (the fst
function asks only for the first argument).

Both of these have their justifications in some situations. Lazy evaluations
brings number of signifficant benefits. First, which we have just seen, is
simplification of the evaluation.  Another one may be a posibility to work with
seemingly infinite lists. In Haskell, there is no problem in constructing an
infinite list of numbers and then take only some small portion of it. The rest
will never gets evaluated because of the lazyness, thus we are safe!

```haskell
fst [1..]
```

Haskell uses **lazy evaluation by default**. It is one of its big strength. On
the other hand, we must not forgot the downside.  From the nature of lazyness
it is apparent that we can never be sure what part of an expression
will get evaluated and what won't. We can't rely on it.  What if the second
argument, which was discarded in the previous example, contains some kind of
side effects? We would not be able to tell for sure that these side effects
happend. Languages which uses lazy evaluation, like Haskell, thus need to be pure (without any side effects).

Ruby, on the other hand, uses eager evaluation by default. You can see it yourself in this example:

```ruby
range = 1..Float::INFINITY
range.map { |x| x * x }.first
==> endless loop
```

Ruby would try to evaluate eagerly the range composed of infinite numbers which would, of course, resulted in infinite loop.

In Ruby 2.0 we can now use **lazy** method provided in the Enumerable module,
which gives us just the functionallity which we want. If you want to know more
about it, I reccommend this [nice article](http://patshaughnessy.net/2013/4/3/ruby-2-0-works-hard-so-you-can-be-lazy)
by Pat Shaugnessy. 


