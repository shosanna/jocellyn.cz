---
title: What is an API?
date: 2014-05-01 18:42 UTC
tags: ruby, rails, programming
layout: post
---

When someone tries to explain me "what is an API", he always sais
something like: "well, it is a programming interface, when you want to
gain some information from a app, you can do it via API". I really did
not understand that.  I finally got it when I started to work on a rails
app with an API used for frontend. So, what is an API?

When you build your web app, you generally do it for humans (at least us
beginners do). We assume that only humans will view our glamorous
landing page, will enjoy our carefully selected fonts and colors, will
read our content.  That is why we have frontend - our views, our css
files and our controllers.  API is something we want to use when we do
not expect humans to interact with our page. What? How? Why?

Well, we do not have to imagine another applications for a while, we can
stick with humans. It is not entirely true, that API is not for them, it
could be. The main difference is that API is serving plain data (for
example as JSON).  When using standard rails way, we are serving
html.erb. Well, how to tell which one to use?

```ruby
class UsersController < ApplicationController
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: @users}
    end
  end
end
```

Do you recognize this code? It is from guides.rubyonrails.org. When
telling the controller which format renders what, we are preparing our
API (the json part) and also our standard views (the html part). If the
user (human) visits `/users` he will get the html view with perhaps nice
listing of all users (with images, css styles, javascripts, etc.. ).
But when someone (human or other app) visits (aka make request)
`/users.json` he will get a looong hash with all the users data. This is
good when you need only that, maybe you want to do some other stuff with
these information, like calculate some statistics? When you just need to
download the data to process them, you do not care about the design.
You need the most efficient way.

Ok, so what about the other apps? Lets say, you want to display your
facebook statuses on your page! What wou will do?  You will make a
request to facebook and ask them to give you the hash of your statuses.
You do not need the whole profile with all the extra information, you do
not care about how it looks, you just need to connect to facebook,
download the data and use them on your page. This is how the two
application can talk to each other - they make requests to their APIs.

I do not want to give lecture about HTTP requests, so just in short,
there are several types of requests, we will be working with GET, POST,
PUT or DELETE. Get is when you are reading stuff, in Rails that is when
you want the `index` or the `show` action (because you want only to see
the content). Post is for creating new stuff, aka `create` and put is
for updating, aka `update` in Rails. Delete is when you want to destroy
some record.  So, when you go to an URL like this: `/users/3` you are
doing a GET request, because you are invoking a `show` action for user
with ID 3.

As you probably guess, you can make a request by going to some URL in a
browser, but you can also do it in terminal (command line) with curl.

```
curl http://localhost:3000/users/4
```

The response to this could be:

```json
{
  "_id":"4",
  "name":"Susan",
  "work":"teacher",
  "facebook":"www.facebook.com/shosanna",
  "createdAt":"2014-04-07T14:47:09.964+02:00",
  "updatedAt":"2014-04-23T13:30:08.241+02:00",
  "email":"dostalovaz@gmail.com",
  "agreedWithTerms":1
}
```

You see? Its UGLY, but it efficient. It is just the information you
asked for.

The curl command uses GET method as default, if you would like to pass
it another one, you could do it like this:

```
curl -X PUT http://localhost:3000/users/4/update -d "{"work":"programmer"}"
```

When you want to change something (via put or post) you need to send
some data along with that request, so that the server can make
appropriate changes. We send the altered work attribute with the "-d"
flag.  (You know, this data will come to our controller as params! -
[see my other article about it](http://jocellyn.cz/2014/04/21/rails-params-it-is-just-a-hash.html)")

Ok, so we know how to make request. Now lets speak a bit more about why
to do it and ... what exactly is this API anyway?

I said something about using API for frontend, well this is one way to
use it. You can completely detach your frontend and communicate with it
by sending along requests and responses through API. Or you can use it
just for a part. Lets show an example, I am having map in my app and I
want to prepare some data to send to the map for displaying them.  The
map is itself in javascript, so I need to send a json.

I will create a special, API controller (now you will understand the API
word!), because the data I want to prepare are not for humans, but are
just for my own map. It will read it and process it and than the end
result will be used by humans. I will separate my new controller into a
API module, because it is better to have a distinction between your
proper controller and those special ones not for humans :)

The other possibility is to use the `respond_to` method in one
controller, as we saw earlier, but I like it better separate..
This way I have one controller which represents my API, because it 
is not using any views, and one which is the normal one.

```ruby
class MapController < ApplicationController
  def index
    # Action could be blank, because it will invoke 
    # its proper view by default.
    # When humans will go to /map, they
    # will see the view under views/map/index.html.erb
  end
end


class Api::MapController < Api::ApplicationController
  def index
    @geo_points = Point.all
    render json: @geo_points
  end
end
```

As you can see, we will not render any html template in our API 
controller, just json. It will not invoke the default view as in
the first case, because when we typed `render` we explicitely said to 
render whatever format is then specified and prevented the default.
Next, we pulled out all our `geo_points` to show them on the map, then we
rendered them via json. This means that every object will be serialized
to json like this:

```json
{"lat":"43242342", "lon":"345432", "city":"Prague", "state":"Czech Republic"}
```

This would came out for every records if the GeoPoint class would have an attributes lat, lon, city and state.

The map we are talking about would need to call the request from
javascript. It itself could be located in a HTML view, but inside that
view we would be calling an javascript file with all the functionality.
The request from javascript could look like this (with using jQuery):

```jquery
// we prepare a variable which will store our response

var page_content;

// we make a request, every request has an answer and that will be stored in our page_content

$.get( "http://localhost:3000/api/map", function(data){
    page_content = data;
});

```

Tadaaa! Notice, that we had to append "api" before "map" in the URL, because our map controller is in API module.
We now have the response (json!) stored in a variable, so we can do stuff with it. It is just a hash, so we can retrieve values by keys:

```

var lat = data[0]["lat"]
var lon = data[0]["lon"]
```

(in real life we would iterate through all the records, here I just used [0] to get the first geo point,
and than I called its lat and lon). Now we have everything we need in order to show the points on the map.

We did it by API - the interface not for visual pleasure but for pure data. The interface for another apps,
another parts of our app, or even humans, who need just to extract the data.

A bit more from real life for the end:
Every successful web application says "we have an public API". This means, they have a list of all the requests
you can do to them. For example, my favourite game League of Legends has [this website](https://developer.riotgames.com/docs/getting-started) about their API.
What you can do, is to make a requests and get the data they prepared for you on their API controllers.
For example, if you make requests to this URL (and replace summonerId with an actual ID)

```
/api/lol/{region}/v2.2/team/by-summoner/{summonerId}
```
you will get back a json with info about all players who are on the same team as the one who's ID you passed in.
This feature, the public API, allows players and fans to create a cool websites. They can make projects which
gains from the official API but show the data in an original way, or they can count en extra statistics for players.
The possibilities are unlimited!!







