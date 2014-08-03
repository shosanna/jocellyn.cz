---
title: Best gems for beginners
date: 2014-07-28 16:49 UTC
tags: rails, ruby, programming
layout: post
---

Ruby Gems are essential for every Ruby on Rails programmer. They are a
small pieces of already written and tested code which provide some
functionality. For example, there are many gems which provides admin
interface for your app. It means that you instal the gem, make some
basic setup and you are all set to use the admin section. You can manage
your resources there. This of course doesn't mean that you can not write
exactly the same thing on your own. You can create admin namespace,
controllers and manually prepare all the views for each of your models.
This is not a hard job, for sure, but it can be quite boring and time
consuming, as you would need to repeat the same steps over and over
again. Not just in one app for several resources but across your apps
which needs such a functionality as the admin section is usually always
same. The whole beauty of gems is that they will save your time by
providing common and well know solutions. 

The downside is that there are plenty of them. Because they solve
popular problems, many people think their solution is the best, so they
create gems. I gathered the most popular ones so that you can know what
to look for when you will need it. I took in account beginner's friendly
gems, those which you would probably need in a fairly simple
applications. Before we proceed to this list, I want to make a quick
recommendation - take a look at all the gems which are over there at the
official site [rubygems.org](https://rubygems.org/) or compare how each
of the gems is used at [ruby-toolbox](https://www.ruby-toolbox.com).

<hr>

## Devise

Devise deserves to get to the top of my list as it is the absolutely
must have solution for quick login / logout / sign up functionality. You
use devise when you want to add sessions for your users, so that they
can authenticate themselves with a password and log into their account.
After adding it to your web app, it generates the controllers which
handle the sessions and the basic views for login page (as well as
registration page, have you lost your password page, etc.) You also get
handy helpers as for example `current_user`, which you can use in your
controller to test if the visitor is logged or in views to display his
name... It is also good when you does not want to deal with security
stuff (encrypting the users' passwords) as it is doing it for you. 

Everything and much more is very deeply described on the [Devise Github
page](https://github.com/plataformatec/devise), but do not forget to
check also their [wiki](https://github.com/plataformatec/devise/wiki).
One last advantage of devise - because it is so widespread and everyone
is using it, when you run into some problems and google it, you will
find a lots of answers. If you wish to explore the other options, [this
article](http://everydayrails.com/2011/09/21/rails-authentication.html)
sums it up.

**Use when: you want to have users authentication on your page. Period.**

## Simple Form

By default Rails uses the `form_tag` or `form_for` for generating forms.
That's ok but with Simple Form your life could be so much easier. Simple
form is a gem which provides a different and more intuitive way of
creating forms. It will generate whole html input with labels, error
fields and hints for you and you just need to specify the fields which
should be updated. It supports collections (so that your users can pick
a value from a list) or associations (so that in one model you can
updated also the associated fields). The best about `simple_form` is
that you just type `form_for @user` and specify the fields, the submit
button and you are ready to go. It is unbelievably quick. The gem is to
be found [here](https://github.com/plataformatec/simple_form).

**Use when: you want to handle your form easily and in the same fashion
through the entire app.**

## Bootstrap

Bootstrap is a frontend framework, it is a set of prepared CSS styles
and JavaScript behaviours which anyone can use and customize on their
web pages. You should take a look at the documentation of
[Bootstrap](http://getbootstrap.com/) because their site is just
amazing. You can just browse the examples and if you like something, you
can copy the code right away. Bootstrap is very elegant and clean way
how to give your page a professional and neat feeling without any actual
design work. It will take care of your forms, make them pretty aligned
and spaced, it will give your buttons a more appealing look, it will make
your tables feel less crowded or it can completely build the navbar for
you. There are several another complex components, there are also icons
which you can use, the grid system for your layouts and JavaScript
tweaks like dropdown menus and much more. The gem for Rails provides
access to all of it.

Of course you do not have to use the gem, you can just download the
source codes from their official page and link them in your application.
Using gem however is a better solution, as it is much faster and easier
and it also will get updated for you whenever you will run `bundle
update`. There is also a third option, which I do not encourage because
it depends on constant internet connection. This is to use the CDN
links. CDN stands for Content Delivery Network and it is a service which
provides only the links (not the actual code) to for example bootstrap.
You can use these links and use bootstrap the same as if you would have
downloaded it. As I said, you need to be online to be able to constantly
reach the content provided elsewhere, which is not exactly good when
developing locally without internet (you would lost big part of your
design). 

So without more talking here is the
[gem](https://github.com/seyhunak/twitter-bootstrap-rails).

Last comment on Bootstrap - if you are afraid you would just be "the
same" as any other webpage using it, don't be. Bootstrap is just a
starting point, it is not your whole design. It is supposed to be
customized and altered. In many pages you would not even tell that it is
using bootstrap. You can apply your CSS or you can even rewrite theirs,
it is completely up to you. Bootstrap is there taking care of the little
things so that you can put all your energy into the big tasks.

Why to bother with grid system and make columns and rows when bootstrap
has one class for it?  If you are fan of frontend framworks, there is
one more which is fairly popular and interesting, it is called [Zurb
Foundation](http://foundation.zurb.com/).

**Use when: you want your app to look good with minimum effort, you need a grid system or
you are just not good with CSS**

## Rspec + Factory Girl

Rspec is a testing framework which makes your testing a pleasure instead
of a pain. It is very intuitive to use and to organize your code into
logical blocks. You can writte stuff like `user.proejects.last.should
be_nil` or `user.projects.count.should_not eql(0)`.  Testing your
controllers is also very easy; you can make request just like this: `get
:index` and compare what cames back `response.should be_success`. Rspec
documentation is [available here](https://github.com/rspec/rspec-rails).

The real beauty is FactoryGirl, which is a replacement for fixtures.
What is it? Well, imagine you want to create objects in your test, but
you do not want to repeat all over again all the necessary attributes
when creating them. With FactoryGirl you can just define all your models
and how to create these in one place and then in all your tests let
FactoryGirl to generate objects based on these premade blueprints. The
gem can be downloaded from
[here](https://github.com/thoughtbot/factory_girl_rails) but there is
not so much documentation. You can take a look at this
[article](http://www.hiringthing.com/2012/08/17/rails-testing-factory-girl.html#sthash.8ZIL68s5.dpbs).

**Use when: you want better testing environment and you want to enjoy writting tests!**

## CanCan

We spoke a bit about Devise, which gives your web app the authentication
system. Cancan is next on turn, because it extends it on authorization. With
cancan you can have several roles applied to different users or groups
and each role can have different rights as you specify. For example, only
redactors can delete posts or only admin can view the admin section or
edit user's details. The system of roles and rights is up to you, CanCan
is just making it easy to achieve. It also have a nice helpers so that
you can instantly know if the current user has the rights for certain
action or not. If you only need an admin role, you can create it easily
on your own, but CanCan is ready for multiple types of authorizations
and for more complex behaviours.

The page for the gem is [here](https://github.com/ryanb/cancan). For
Rails 4, use newer version called
[CanCanCan](https://github.com/CanCanCommunity/cancancan).

**Use when: you want to have users authorization and you plan to have
more complex access logic than just "admin can do all".**

## Act as taggable on

I Love this simple gem! You just add one line of a code into your model
which you wish to have tags, and ... boom! You have tag behaviour :) It
is good when you want one object to have one or zero or multiple tags
and you want to filter based on that. The tags themselves are just plain
names without any more information and can serve for categorization as
well. You can add taggs to an object, view all its tags, search the
entire model for records with specific tags, and so on. It doesn't even
have to be tag, you can define your own attributes with similar
behaviour but different name, like for example skills. Take a look at
the example from the [gem
page](https://github.com/mbleigh/acts-as-taggable-on).

```ruby
class User < ActiveRecord::Base
  acts_as_taggable 
end

@user.tag_list.add("awesome", "slick")
@user.tag_list.remove("awesome", "slick")
```

**Use when: you want to support tags or tag-like behaviour with ease -
for example books can have categories, people can have skills,
discussion topics can have themes...**

## Rolify

Rolify enables you to add, what a surprise, a role to your models!
It plays well with `CanCan` because you can add a role like `admin` or
`manager` to certain users and then you can manage their access
rights via `CanCan`. Rolify will help you only with the assignments of
roles. You can make it very simply by yourself with just adding a boolean
attribute to your model, with the same name as the required role - admin
for example. To set an user a admin, you would just do `user.admin =
true`. But Rolify will give you much more than that. You can have
multiple roles without adding a new attributes for them, you can easily
check if someone has that role and you can also search all the records
with a given role. It is quite similar to previously discussed Act as
Taggable on, but for a different purpose. [Check it out
here](https://github.com/RolifyCommunity/rolify).

**User when: you want multiple to have roles for your model so that you
can for example build your athorization with them**

## Carrierwave

Carrierwave is used for image uploading. It is very simple and quick,
but I will not explain it here as there are several great tutorials for
it out there. You can check [this
article](http://www.sitepoint.com/processing-images-with-carrierwave/)
or [this
one](https://blog.engineyard.com/2011/a-gentle-introduction-to-carrierwave)
or continue directly to a [CarrierWave
page](https://github.com/carrierwaveuploader/carrierwave).

**Use when: you want your users to have a possibility to upload images -
for example as their profile pictures**

## Better Errors + Pry

I am not sure if this is a fit for beginners, but I love it so I will just
briefly recommend it. Better Errors enables a very smart error page
instead of the default one which is not telling you much. With Better
Errors, you got a instant access to REPL whenever there is an error in
your app - it is very useful for debugging. [You can find it
here](https://github.com/charliesome/better_errors).

Pry is even better, it gives you a possibility to set a place in your
code, where you want to stop to debug and open a REPL in that place. You
can gain an insight into what is happening within your code at that
exact moment you need it. It is very very handy and it also have syntax
highlighting! [Here it is](http://pryrepl.org/).

**Use when: if you ever wrote something like `puts 'here it still
works!'` - forget puts statements it and debug like a pro!**

## Act as indexed

[Act as indexed](https://github.com/dougal/acts_as_indexed) is pain-free
way how to add a full-text search into your app. 

**Use when: you want a quick way how to search through multiple fields in a model**

## Active Admin

Active Admin is used to add en entire admin section to your page - with
management of your resources. If you want to for example view all
records, delete selected ones, add new ones and alter existing ones and
you need to do it for several resources, it is just for you. It will
build the entire interface for you. [Here is its official
page](http://activeadmin.info/).

**Use when: you want complex solution for admin section - you want to
manage multiple models at one place**

## Party Boy

Allows you to model relationships between models - add friends, follow
users, block users, etc.. With party boy it is easy to just write
`user.follow(user2)` to start a following relationship or to check for
existing ones via `user.followers`. You can use it for creating
Facebook-like friends and permission to see their statuses, to implement
notification about your friends activity and much more. It just does
what it supposes to do. [here is its
Github](https://github.com/mnelson/party_boy)

**Use when: you want your users to be friends or followers :)**

## Will paginate

Have you ever have a index of all records with more than 100 records in
it? [Will paginate will fix it with simple pagination
option](https://github.com/mislav/will_paginate).

**Use when: you want to add multiple pages into index and have the
possibility to paginate them**

## Public Activity

Will add a feed of notifications to your app! You can combine it nicely
with `Party Boy` to display news within a user's friends just like a
Facebook or Twitter notification bar. It has [very nice
documentation](https://github.com/pokonski/public_activity) with a
guide and lots of examples so I encourage you to study it there.

**Use when: you want to record what is happening in your app and give
your users these information as a news feed**



