---
title: Attributes are just methods
date: 2014-04-24 19:27 UTC
tags: programming, ruby, rails, mongodb
---

I am not sure if many beginners know that, because I did not, but attributes in rails are just a methods.
It is not anything fancy and special, really. Let's explain it with an example.

Imagine situation that you are receiving
params, which are not exactly matching with your model's attributes. (Well, this is of course
nonsense when you are sending the data on your own from a form, but consider sending from
another application trough lets say json api).

Your params could look like this:

```
{user: {name: "Olaf", age: "7", interest: "playing"}}
```

And your models could look like this:

```
class User

    field :interests, type: Array
    field :name, type: String
    field :age, type: String

    # Typing fields like this is a MongoDB speciality
    # when using Activerecord you would not have it here,
    # you would see your attributes in db/scheme
end
```
Notice, that we are getting one interest from params, but our model stores an array of many interests.
The rest of the attributes are without problems.
When you would like to for example update your current user with those params from above,
you could be tempted to create the custom logic for saving the different parameter in your controller.

Maybe you would call the `update_attributes` for the rest of the params, and then you would
call `user.interests << params[:interest]` but this is wrong. All your updating should
be handled by this one method, `update_attributes`. So, let's present a solution.

You could take advantage from my initial phrase ("attributes are just methods") and create a
virtual, helper attribute called the same way as your param. You need to define its getter and
setter, aka how you will retrieve its value and how you will change it.

```
class User

    field :interests, type: Array
    field :name, type: String
    field :age, type: String

    def interest
        self.interests[0]
    end

    def interest=(value)
        self.interests << value
    end
end
```

Now, when we call `interest = something` we are actually filling our proper attributes, the right
one (`interests`). We are encapsulating it by a helper attribute. Why?
Because when we do in our controller:

```
def update
    user = User.find(params[:id])
    user.update_attributes(params.require(:user).permit(:interest, :name, :age)
end
```

That will be just enough. Update attributes will call the setter of each of the attributes. It will take a look at:

- name -> och, it is a attribute so I can save it with the user
- age -> och, it is a attribute so I can save it with the user
- interest -> hmm, it is not in the fields, but ...! there it is, in my user model at the bottom... I know how to call interest=!

We do not actually have a field "interest" but we made a setter for it on our own. The `update_attribute` can proceed.
Who cares, that the setter actually sets a value into a different attribute. It is there, therefore this will work.
How amazing!