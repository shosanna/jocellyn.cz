---
title: Rails params - it is just a hash
date: 2014-04-21 12:59 UTC
tags: programming, ruby, rails
---

I am learning Ruby on Rails for over a year and today I finally understood params. It has been a long way.
I have no idea if only I was struggling with such a simple concept or if is the cause of confuse for many beginner
programmers like me, but I decided to write about it anyway.

At first impression I thought that params are something magical.
I thought that i can get something from params only if I submit a form, like this:

```
<%= simple_form_for @game do |f| %>
    <h1> Create a new game </h1>

    <h3> Properties</h3>
    <%= f.input :name %>
    <%= f.input :from %>
    <%= f.input :to %>

    <h3> Players </h3>
    <%= f.association :players, :input_html => { :multiple => true } %>

    <%= f.button :submit, class: ‘btn btn-primary’ %>
<% end %>
```

From this code it is clear and obvious that in the controller action (in this case it is game#create)
you have access to something like:

    game = Game.new

    game.name = game(params[:name])

The name was send in the form and labeled as a name when I used:

    <%= f.input :name %>

But what about something a little bit more mysterious, like id? A game is very common to find based on its ID.
But where is the id coming from?

When we want to see the view page for an existing record, we go to the URL which looks like this: /games/1
The id is incorporated into the URL, hence we can do (in our games controller, show action):

    @game = Game.find(params[:id])

The params could be sent by a form OR could be fetched from the URL. That is the most fundamental rule!

What amaze me the most is that you can add anything to the URL and play with params all day long!
For a decades I believed that params is something special which you can not control.
You have this params from forms and this params from Url which represents an id. Not true!
Params is a hash, so you can create your own and send it to the controller, so that you can use it in various cool actions.
Check this out:

    <%= link_to sprites_path(filter: “Ship”) do %>
    <button class=”btn btn-primary”> Only ships </button>
    <% end %>

I just invented a filter params. Oh yes, I just typed it and it exists.
Now I can filter the results based on whether or not this button was clicked:

    def index
    if params[:filter]
    @sprites = Sprite.select {|a| a.type == params[:filter] }
    else
    @sprites = Sprite.all
    end
    end

In this case, I can create many buttons for each type one and when it’s clicked,
the params[:filter] will take corresponding value.
Because I named the filter value in the hash same as the actual types of sprites in my model, it will behave automatically.
Otherwise I could do something like:

    if params[:ship]
    @sprites = Sprite.select {|a| a.type == “Ship” }
    els if params[:rocket]
    @sprites = Sprite.select {|a| a.type == “Rocket” }
    else
    @sprites = Sprite.all
    end

The links would look like this:

    <%= link_to sprites_path(ship: true) do %>
    …
    <% end %>

    <%= link_to sprites_path(rocket: true) do %>
    …
    <% end %>

To summarize what we just learnt - When using a link to go to an URL,
I can add a params to it and I can invent any params I want. This is also correct

    <%= link_to root_path(unicorn: “shiny”, frog: “ugly”) %>

It is just a hash which will be added to the url.
The controller and the action which your link leads to will be able to retrieve this hash and do stuff with it.
Like use it in a filters.

Note that you can link to the same controller action which you are right now.
This means that you will not leave the page, only your params will be added.
I used this for example when I needed to prepare a more complicated selection process and than send it with all the params at once.

To wrap it all up, params are your way to communicate with controller.
You can send information from the views by submitting a form
(another cool trick is to include a hidden tag to your form so that some information
will be always sent along with the user’s filled inputs). You can send information by adding them to the URL.
You can make a link which goes to another or the same page and adds () with your params. Simple like this:

    <%= link_to “Hello world”, dashboard_path(hello: “world”) %>