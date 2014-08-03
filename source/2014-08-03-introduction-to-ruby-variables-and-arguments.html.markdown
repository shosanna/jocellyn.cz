---
title: Introduction to Ruby variables and arguments
date: 2014-08-03 20:34 UTC
tags: Ruby, programming
layout: post
---

There are several types of variables in Ruby, each of these has a
different use and different naming conventions. We will closely examine
`local` variables and their assignments in methods in this article, but just to be sure, this table
should briefly summarize all Ruby variables as well as other identifiers
like constants, keywords and methods names. 

<table class="table">
 <tr>
    <th> Type </th>
    <th> Naming convention </th>
    <th> When to use </th>
  </tr>
<tr>
  <td>Local variables </td>
  <td><code>my_hero</code> </td>
  <td>Inside of a method or a block - they have only limited scope </td>
</tr>
<tr>
<td>Instance variables </td>
<td><code>@my_hero</code> </td>
<td>When you want to store information for individual objects </td>
</tr>
<tr>
  <td>Class variables </td>
  <td><code>@my_hero</code> </td>
  <td>When you want to store information regarding the whole Class </td>
</tr>
<tr>
  <td>Global variables </td>
  <td><code>$MY_HERO</code> </td>
  <td>When you want to access them globally - from multiple places </td>
</tr>
<tr>
  <td>Constants </td>
  <td><code>MY_HERO</code> </td>
  <td>When you want to store a data of a permanent nature </td>
</tr>
<tr>
  <td>Keywords </td>
  <td><code>if</code> </td>
  <td>For special tasks and contexts - these are Ruby reserved words (like `def` for method definition) </td>
</tr>
<tr>
  <td>Methods names </td>
  <td><code>my_hero</code> </td>
  <td>For calling or defining methods </td>
</tr>

</table>

Local variables are used to store a reference to an object. Ruby is a
dynamically typed language, that means that a variable is bound only to
object, not to its type (like it is in statically types languages like
Haskell). Object could be a String, Integer, Boolean, ... it does not
matter what type it has, a variable can store any type and then be
reassigned to store something different, like here:

```ruby
my_var = "this is string" 
my_var = 123
```

It is important to understand, that the variable is not containing
anything, it is just pointing to an object like a reference. If the object to which it is bound
changes, the variable also changes. 

```ruby
my_var = "this is original string"
new_var = my_var

puts new_var 
#=> this is original string

my_var.replace("BUM!")
puts new_var 
#=> BUM!
```

This example shows the use of a string method `replace` which change the
string in place. It is still the same object - a string object - but wit
ha different value inside. On the contrary, if we would have done
`my_var = "BUM!"` we would have assigned to that variable a whole new
object and the above example would not work. If you would like to be
sure, you can insepct the object which the variable is pointing at with
an `object_id` method.

```ruby
puts my_var.object_id
#=> 70197558178100
puts new_var.object_id
#=> 70197558178100
```

Ok, so we disocovered how local variables works, now lets take a look at
how they are used inside of methods. 

## Arguments and parametres
When you are defining a method, the variables which are used to identify
data passed in and are called `parametres`.
When you are calling a function and you are passing an `arguments`. It
may seems like the same thing, but it is not. It doesn't need to have
the same names, the method will recognize them based on the order you
passed them in. 

```ruby
def substract(x,y)
  x - y
end

substract(8,2)
#=> 6
```

In this case, `x` and `y` in the definition are a function parametres.
They are variables which are used to store and name stuff which came
into our function from outside, so that we can refer to these inside.

8 and 2 are arguments, they are the concrete objects which we feed into
our function to produce a results. Ruby will bind 8 to `x` and 2 to `y`
because 8 came first and 2 came after it.

The variables defined inside of a method or its parametres are visible
only in that method. It is called a `local scope` - you can not see it
from outside. 

The parametres which we talked about so far were all required, which
means that if you would try to call the function with a different amount
of arguments than it has parametres, you would get an error. There are
also optional parametres, which you may or may not provide. You just
need to put an asterisk in front of the parametr name `*x`.

```ruby
def maybe_something(*a)
  puts "I got .... "
  puts a
end

maybe_something(1623)
#=> I got ....
#=> 1623

maybe_something
#=> I got ....
```

Another way how to make an parametr quasi optional is to state its
default value. In that case, if it is provided, the one user would feed
in wil be used, otherwise the default value will got applied. You can
make this like this: `(a=4)`

Be aware of a parametres assignment order - the required ones always
take precedents, does not matter where they are. If you have a
definition like this `def method(a,b,c*,d,e)` and you call it with only
4 arguments, `a`,`b`,`d`,`e,` will get occupied but not the optional
`c`, which will be left with nothing.

```ruby
def method(a,b,c*,d,e)
  p a, b, c, d, e
end

method (1,2,3,4)
#=> 1
#=> 2
#=> []
#=> 3
#=> 4
```

