---
title: Ruby function arguments explained
date: 2014-08-03 20:34 UTC
tags: Ruby, programming
layout: post
---

There are several types of variables in Ruby, each of these has a
different use and different naming conventions. We will closely examine
`local` variables and their usage in methods in this article, but just
to be sure, this table should briefly summarize all Ruby variables as
well as other identifiers like constants, keywords and methods names.

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
Haskell). The object could be a String, an Integer, a Boolean, ... it
doesn't matter what type it is, a variable can store any type and then
be reassigned to store something else, like here:

```ruby
my_var = "this is string"
my_var = 123
```

It is important to understand that the variable only contains a
reference to the object, not the object itself. If the object the
variable references gets changed in another place, that change will be
reflected when we use the variable.

```ruby
my_var = "this is original string"
new_var = my_var

puts new_var
# => this is original string

my_var.replace("BOOM!")
puts new_var
# => BOOM!
```

This example shows the use of a String method `replace`, which changes
the String in place. It is still the same object - a string object - but
with a different value inside. On the contrary, if we would have done
`my_var = "BOOM!"` we would have assigned to that variable a whole new
object and the above example would not work. If you would like to be
sure, you can inspect the object which the variable is pointing at with
the `object_id` method.

```ruby
puts my_var.object_id
#=> 70197558178100
puts new_var.object_id
#=> 70197558178100
```

Ok, so we discovered how local variables work, now lets take a look at
how they are used inside of methods.

## Arguments and parameters

When you are defining a method, the variables which are used to identify
data passed in and are called `parameters`, but when you are calling the
method you are passing `arguments`. It may seem like the same thing, but
it is not. It doesn't need to have the same names, the method will
recognize them based on the order you passed them in.

```ruby
def subtract(x,y)
  x - y
end

subtract(8,2)
# => 6
```

In this case the `x` and `y` in the definition are a function
parameters. They are local variables which are used to store and name
the objects which came into our function from the outside, so that we
can refer to them inside.

8 and 2 are arguments, they are the concrete objects which we feed
into our function to produce the results. Ruby will bind 8 to `x` and 2 to
`y` because 8 came first and 2 came after it.

The variables defined in the method and its parameters are visible
only in that method. It is called a `local scope` - you can not see it
from the outside.

The parameters which we talked about so far were all required, which
means that if you would try to call the function with a different number
of arguments than it has parameters, you would get an error. There are
also optional parameters, which you may or may not provide. You just
need to put an asterisk in front of the parameter name `*x`.

```ruby
def maybe_something(*a)
  puts "I got ..."
  puts a
end

maybe_something(1623)
#=> I got ...
#=> 1623

maybe_something
#=> I got ...
```

Another way how to make a parameter quasi optional is to state its
default value. In that case, if it is provided, the one user would feed
in will be used, otherwise the default value will got applied. You can
do it like this: `(a=4)`

Be aware of the parameter assignment order - the required ones always
take precedence, it doesn't matter where they are. If you have a
definition like this `def method(a,b,c*,d,e)` and you call it with only
4 arguments, `a`,`b`,`d`,`e,` will get assigned, but not the optional
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

So we have seen how methods use `parameters` to take an input from outside.
These parameters are called `arguments` of a function call. If you
would like to call a method without any arguments, you just type its
name like this:

```ruby
do_stuff
```

So how does Ruby tell if that is a method call or something else? Well,
if it sees a word starting with lower case, like `do_stuff`, it firstly
checks if it is not a keyword. Ruby has an internal list of all keywords
so it knows how to recognize these. If not, it looks for an equal sign `=`.
If it is there, the expression is then perceived as variable which is
being assigned. If none of those cases match, it is assumed to be a
method call.

