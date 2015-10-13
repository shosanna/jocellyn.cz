---
title: Simple charts with C3 - in 5 minutes!
layout: post
date: 2014-07-25 18:43 UTC
tags: javascript, programming, visualization
---
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/d3/3.4.11/d3.js"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/c3/0.1.29/c3.js"></script>


This article aims to explain how to use a cool library called <a href="http://c3js.org/">C3</a> for building simple charts. C3 is a javascript library
which builds on top of <a href="http://d3js.org/">famous D3</a>. You can find plenty of good sources (online or printed) on how to learn D3 and make
complex visualizations with it, but for many people, these would be too advanced. Often you just need to add a <strong>simple graph to
a webpage </strong> to show some statistics - a scatter plot or a bar chart.

C3 allows you to do just that without knowing all the complexity of D3 because it wraps all you need into a simple API.
You do not need to handle the SVG elements manually, nor the hover effects, etc.
The final result could look like this:

<div id="chart"></div>
<script>
var chart = c3.generate({
    data: {
        columns: [
            ['Lulu', 50],
            ['Olaf', 50],
        ],
        type : 'donut'
    },
    donut: {
        title: "Dog love",
    }
});
</script>

<h2> How to do that in 5 minutes </h2>
<strong> Installation (2 minutes) </strong><br>
To set a C3 for your webpage you need a three things:
<ul>
    <li>D3 JavaScript file </li>
    <li>C3 JavaScript file </li>
    <li>C3 stylesheets file </li>
</ul>

You can download all three sources on their official sites (<a href="http://c3js.org/">C3</a>,<a href="http://d3js.org/">D3</a>), put them into the same file as your page and then linked them as you would do with any other scripts and styles.
Or you can chose a elegant solution to link to external services which host these files for you. Here they are:

```html
<!-- These belongs to the HTML file where you want C3 to work - put these lines into your <head> tag -->
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/d3/3.4.11/d3.js"></script>
  <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/c3/0.1.29/c3.js"></script>
  <link href="//cdnjs.cloudflare.com/ajax/libs/c3/0.1.29/c3.css" rel="stylesheet" type="text/css">
```

Be aware though that relying on external service could not be as reliable as hosting these files on your own, and you - of course - need internet connection all the time for them to work.

<strong>Preparing your HTML (1 minute)</strong><br>
Now we need to choose an element in our HTMl page to which the chart will bind. It only means that we will specify, where we want the chart to be displayed.
We can do this by adding an ID called `chart`. The element can be empty as well as it can contains other things, it does not even need to be a `div`. However, if it contains a text,
this will not be visible as the chart will render over it.

```html
<div id="chart"></div>
```

```html
<h1 id="chart">This text will not be visible</h1>
```
<br>
<strong>Setting your JavaScript (2 minutes)</strong><br>
Last but most important part is the actual code for the chart. Here is the donut pie from the introduction:

```javascript
var chart = c3.generate({
    data: {
        columns: [
            ['Lulu', 50],
            ['Olaf', 50],
        ],
        type : 'donut'
    },
    donut: {
        title: "Dogs love:",
    }
});
```

It is very simple. The first line says that we are generating a chart and assigning it to a variable for later use.
This chart consists of what is inside these ({...}). The inner part of the braces tells us more details about it. First and most important is the `data` part.
Here we are hardcoded an array of arrays, it means our chart will have two values. The first element in the inner array is the label, the second the value.

Then we are specifying the type of a chart, if I changed `donut` for a `bar`, I would get this:

<div id="chart2"></div>
<script>
var chart = c3.generate({
    bindto: '#chart2',
    data: {
        columns: [
            ['Lulu', 50],
            ['Olaf', 50],
        ],
        type : 'bar'
    },
    donut: {
        title: "Dogs love:",
    }
});
</script>

This was super easy! Of course your data can be much more complex, putting more values into the inner arrays for example means comparing the values on the same indexes to each other, like this:

```javascript
data: {
    columns: [
        ['Lulu', 50,4,3,2],
        ['Olaf', 50,6,8,1]
    ]
  }
```

Means looking at first value from Lulu's array (50) and first value from Olaf's array (50) and putting them together into one column, then doing the same with other values and shifting the columns
along the X axis. This is the result:

<div id="chart3"></div>
<script>
var chart = c3.generate({
    bindto: '#chart3',
    data: {
        columns: [
            ['Lulu', 50,4,3,2],
            ['Olaf', 50,6,8,1],
        ],
        type : 'bar'
    },
    donut: {
        title: "Dogs love:",
    }
});
</script>

I prepared a JSbin for you, so that you can play around and try these simple charts.
<a href="http://jsbin.com/vuhoy/1/edit?html,js,output" target="blank"><span class="btn btn-primary">Go check it out</span></a>.

<br>
<h2>Customization</h2>
From the official site you can grap examples to many different styles of graphs. There is line chart, bar chart, pie chart, area chart, step chart, scatter plot, spline chart,... I do not even know
what they all mean. But it can be confusing for a beginner to see how he can customize these charts based on his needs.

In general, the pattern is always the same - you look up some feature you would like to add or change in the example page <a href="http://c3js.org/examples.html">here </a>,and then you put just this line into your
code. The only tricky part is where to put it, because sometimes it should go into the data object, as for example setting ` data labels`:

```javascript
var chart = c3.generate({
    data: {
        columns: [
            ['data1', 30, -200, -100, 400, 150, 250],
            ['data2', -50, 150, -150, 150, -50, -150],
            ['data3', -100, 100, -40, 100, -150, -50]
        ],
        type: 'bar',
        labels: true
    }
});
```

And sometimes it needs to be added as separate object, next to data, like this example with `axes labels`:

```javascript
var chart = c3.generate({
    data: {
        columns: [
            ['sample', 30, 200, 100, 400, 150, 250],
            ['sample2', 130, 300, 200, 500, 250, 350]
        ],

    },
    axis: {
        x: {
            label: 'X Label'
        },
        y: {
            label: 'Y Label'
        }
    }
});
```

You can customize all sorts of properties like this, for example:

-  `order: 'desc'` // could be 'asc', 'desc' or null, which means the order based on data definition
-  `legend: { show: false }` // hide the legend
-  `types: { data1: 'step', data2: 'area-step }` // if you want to combine multiple types of charts for each data
-  `size: { height: 240, width: 480 }` // size of the chart
-  `colors: { data1: 'hotpink', data2: 'pink' }`

Lets check an example!


<strong>Custom colors for our chart</strong><br>
I like pink!

<div id="chart4"></div>
<script>
var chart = c3.generate({
    bindto: '#chart4',
    data: {
        columns: [
            ['data1', 300, 350, 300, 0, 0, 0],
            ['data2', 130, 100, 140, 200, 150, 50]
        ],
        types: {
            data1: 'area',
            data2: 'area-spline'
        },
         colors: {
                   data1: 'hotpink',
                   data2: 'pink'},
    }
});
</script>

```javascript
var chart = c3.generate({
    bindto: '#chart4',
    data: {
        columns: [
            ['data1', 300, 350, 300, 0, 0, 0],
            ['data2', 130, 100, 140, 200, 150, 50]
        ],
        types: {
            data1: 'area',
            data2: 'area-spline'
        },
         colors: {
           data1: 'hotpink',
           data2: 'pink'
         }
    }
});
```

Did you also notice, how we stated `bindto` to `#chart4`? If we would have left the default binding, which is to `#chart`, the initial chart from the beginning of the article would have been rewritten
by this one. To have multiple elements with multiple bindings is the way how to keep more than one graph in one page.


<br>
<strong>Loading data dynamically from an HTML attribute</strong><br>
One requested feature is the ability to load data dynamically, because hardcoded like in these examples they would be the same all the time.
If you for example want to show some live data, statistics, etc. You can fetch the actual data through AJAX directly from JavaScript or you can communicate with your HTML data attributes like this:

```html
<div id="offer-need" data-source="<%= @statistics.data_offer_need %>"></div>
 ```

 Do not worry about the syntax, it is Ruby, but if you are programming in some language I am sure you know some way how to send a data from server to your HTML templates like this.

 ```javascript
 var dataSource = $("#chart-offer-need").attr("data-source");

 var data = JSON.parse(dataSource);

 var chart = c3.generate({
   bindto: '#chart-offer-need',
   data: { columns: data }
  });
```

We fetch the data from the attribute using `.attr` and then we parse it.

<h2>Final thoughts</h2>
C3 is a great and simple tool how to make a chart in literally 5 minutes. Do not forget though, that is is based on D3, a much much much more powerful tool.
If you like these little visualizations and plan to do them more seriously, I recommend to check D3 as well..

I was a not a completely honest when I said that it is hard. It is
maybe difficult when compared to C3, but it is not anything horrible and anyone can learn it. With D3 you can make charts exactly as you want them, and not just charts! You can visualize almost everything,
check out nice examples in the official site.

Also, D3 allows you to scale your axes properly based on your data. This is very important concept, because you most often would need to display some values bunt in
a slightly bit different scale or proportion. C3 is good for quick tasks, but D3 has the true power. I recommend <a href="http://shop.oreilly.com/product/0636920026938.do">this book about it. </a>
