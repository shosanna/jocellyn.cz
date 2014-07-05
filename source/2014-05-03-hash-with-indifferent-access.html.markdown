---
title: Hash with indifferent access
date: 2014-05-03 09:40 UTC
tags: ruby, rails, programming
layout: post
---

Hash with indifferent access is the actual class of Rails params, so
technically speaking it is not just a hash, as [I
wrote](http://jocellyn.cz/2014/04/21/rails-params-it-is-just-a-hash.html) :)
The "indifferent access" sounds scary but I am sure you all know what it
means. When you want to get a value based on a key, the key can be
written as **string as well as symbol.**

```ruby
# We will set our new hash with i.a. with one key/value pair
dogs = ActiveSupport::HashWithIndifferentAccess.new
dogs[:husky] = "Matt"

# we can get the value by both, string and symbol
dogs[:husky] # => "Matt"
dogs['husky'] # => "Matt"
```


The string and the symbol is treated as a same thing. If you want to
explicitely convert all the keys to one or other, you can use
`stringify_keys` or `symbolize_keys` method. Anyway, if we create a hash
with symbol keys, it will be converted to string internally.

```ruby
symbol_hash = ActiveSupport::HashWithIndifferentAccess.new
symbol_hash[:foo] = "bar"

symbol_hash # => {"foo" => "bar" }
```
This is because the []= method is converting keys and values for string
every time it is used. Look at the implementation of that method in
Rails:

```ruby
def []=(key, value)
  regular_writer(convert_key(key), convert_value(value, for::assignment))
end

def convert_key(key)
  key.kind_of?(Symbol) ? key.to_s : key
end
```

You should be aware of using regular hashes and hashes with indifferent
access as putting these two together may end up unexpectedly. If you
merge them together and they contain the same keys,
you will end up by having both, not just the later ones. 

```ruby
regular = Hash.new
regular[:one] = 1
regular[:two] = 2

regular # => {:one=>1, :two=>2}

indifferent = HashWithIndifferentAccess.new
indifferent[:one] = "one"

regular.merge(indifferent) # => {:one=>1, :two=>2, "one"=>"one",
"two"=>"two"}
```

Hovewer, if you do it the opposite way (merging regular into
indifferent) it will do what is expected and we will have the later
values: `{"one" => 1, "two" => 2}` but it will become also an
indifferent hash, so the keys wil be stringified.

P.S. if you want to play with these example in your console, do not
forget to include the hash with indifferent acces like this:

```ruby
require "active_support/hash_with_indifferent_access"
```

