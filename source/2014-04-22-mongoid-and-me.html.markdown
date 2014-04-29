---
title: Mongoid and me
date: 2014-04-22 20:57 UTC
tags: programming, rails, ruby, mongodb,
layout: post
---

I got a new amazing job as a junior Ruby on Rails programmer. Everything
is great except the fact that I am very often struggling with things
which the textbooks do not teach. For example, let me speak a bit about
MongoDb and the "amazing" mongoid.

I was very shocked when I realized that switching to another database
means that all the active record stuff which I am used to are no longer
availible. It felt like a half of the rails was gone. I can't type
`User.first` in my conzole? I can't validate? The project I am working
on is using MongoDB, the popular no-no-no-no SQL database which is
supposed to be very flexible and cool. But it is just a database, when
it comes to querying and acting like active record, here comes Mongoid. 

Mongoid is a gem which allows you to do several useful things like
define attributes on a model just by typing:

```
field :name, type: String
```

Or making assocciations like has_many, belongs_to or a new and handy
embedds_one or many. The difference between the classical relationships
and the embedded ones is that the later can not exist on their own. They
are dependent on theirs masters. For example:

```
class User
embedds_one :location
end

class location
embedded_in :user
field :address, type: String
end
```

Typing in console `Location.new(address: "Vinohradska 40, Prague")` and
then trying to save will not work, it is allowed to create a location
only in context of creating a user. I don't mind that anyway, I can
always use the classical relationships. I wanted to speak about what
sucks at Mongoid. 

Well, it is mainly the error handlings. I am consantly getting
mysterious error from deep down of Mongoid, when I am just forgetting
to return the correct value. The error raised by Mongoid will never tell
you what is wrong, it will just leave you in questions. Even though I am
just calling, lets say a wrong method to a wrong thing, it will tell me "undefined method "compact"
for nil". Compact? There is no compact in my code, this is coming from
... from ... I have no idea where. 

Another thing are migrations. It is really cool I do not have to migrate
just for adding a field, but to migrate data? I just can't used to it.
I just feel that I can live with migratinf columns rather than to risk
my data and migrate them every time I need to do a smallest change.

The querying is also not exactly what you would expect. Sure, it works
almost as with SQlite, but almost. It is maybe stupid but I was really
struggling for a long time before I reallize that `User.all` isn't
broken, you just need to do `User.all.to_a' in order to get a list of
all users. It is not really intuitive.  

Well, I will have to stick with Mongo and Mongoid for a while, so better
to get used to it and start working on understanding it!


