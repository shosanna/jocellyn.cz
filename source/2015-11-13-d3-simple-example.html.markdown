---
title: D3 simple visualization (Visu homework V)
date: 2015-11-13 19:44 UTC
tags: visualization, javascript, programming
layout: post
---

<style>
body { 
    font: 10px sans-serif; 
    margin: 2; 
}

.label {
    position: absolute;
    padding: 3px;
    left: 0;
    color: teal;
}

.bar {
    background-color: pink;
    margin-bottom: 2px;
    padding: 3px;
    position: absolute;
    left: 35px;
}
#chart {
  height: 300px;
  position: relative;
  bottom: 10px;
}
</style>
# The code
    var years = [2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014];
    var values = [255917,280111,323343,394345,439498,434600,426423,436319,438076,441536,451923];
    
  
    var chart = d3.select("#chart");
    var label = chart.selectAll("div").data(years)
    var bar = chart.selectAll("div").data(values)
    
    // a scale takes a value from a domain - in this case one of the values of our dataset and projects it into the range - in the case to something between 0 and 500 pixels. It means that the smallest value of our dataset will be represented as 0 and the biggest as 500.
    var scale = d3.scale.linear()
          .domain([d3.min(values), d3.max(values)])
          .range([0,500])
    
    // here we are actually creating the labels - we are appending divs, giving them CSS class and styling their top position and puting a text inside the div.
    label.enter()
         .append("div")
       .attr("class","label")
         .style("top", function(d,i) { return i*25 + "px"})
         .text(function(d) { return d })
    
    // here we are actually creating the bars - we are appending divs, giving them CSS class, styling their width with the use of the scale, styling top position and puting text inside (of a value of a dataset value).
    bar.enter()
      .append("div")
      .attr("class","bar")
      .style("width", function(d) { return scale(d) + "px" })
      .style("top", function(d,i) { return i*25 + "px"})
      .text(function(d) { return d })
    
      // interactivity - on mouseover change background color of the bar
    .on("mouseover", function() {
          d3.select(this)
            .style("background-color", "orange");
    })
       .on("mouseout", function() {
          d3.select(this)
            .style("background-color", "pink");
    })

# The result
<div class="wrapper">
  <div id="chart"></div>
</div>

<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/d3/3.4.11/d3.js"></script>
<script>

    var years = [2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014];
    var values = [255917,280111,323343,394345,439498,434600,426423,436319,438076,441536,451923];
    
  
    var chart = d3.select("#chart");
    var label = chart.selectAll("div").data(years)
    var bar = chart.selectAll("div").data(values)
    
    // a scale takes a value from a domain - in this case one of the values of our dataset and projects it into the range - in the case to something between 0 and 500 pixels. It means that the smallest value of our dataset will be represented as 0 and the biggest as 500.
    var scale = d3.scale.linear()
          .domain([d3.min(values), d3.max(values)])
          .range([0,500])
    
    // here we are actually creating the labels - we are appending divs, giving them CSS class and styling their top position and puting a text inside the div.
    label.enter()
         .append("div")
       .attr("class","label")
         .style("top", function(d,i) { return i*25 + "px"})
         .text(function(d) { return d })
    
    // here we are actually creating the bars - we are appending divs, giving them CSS class, styling their width with the use of the scale, styling top position and puting text inside (of a value of a dataset value).
    bar.enter()
      .append("div")
      .attr("class","bar")
      .style("width", function(d) { return scale(d) + "px" })
      .style("top", function(d,i) { return i*25 + "px"})
      .text(function(d) { return d })
    
      // interactivity - on mouseover change background color of the bar
    .on("mouseover", function() {
          d3.select(this)
            .style("background-color", "orange");
    })
       .on("mouseout", function() {
          d3.select(this)
            .style("background-color", "pink");
    })
    </script>

