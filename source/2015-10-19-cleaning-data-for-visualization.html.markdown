---
title: Cleaning data for visualization (Visu homework II.)
date: 2015-10-19 19:07 UTC
tags: visualization
layout: post
---

Before you can start with any vizualization, you usually need to clean up the data a bit. You will almost never got the data in the exact format and shape which you need.
Take my homework as an example - we were suppose to do simple vizualization in Excel, but we got a huge amount of data. This is the original data source which we got: 

[https://vdb2.czso.cz](https://vdb2.czso.cz/vdbvo2/faces/index.jsf?page=vystup-objekt&str=&evo=&verze=-1&nahled=N&sp=N&nuid=&zs=&skupId=&pvokc=&filtr=G~F_M~F_Z~F_R~F_P~_S~_null_null_&katalog=31032&pvoch=&pvo=CIZ08&udIdent=&zo=N&vyhltext=&z=T#w=)

It comes from the Czech statistical agency, which is pretty standard source of information of stastical nature. 
Data represents amount of immigrants comming to the Czech Republic from different countries between years 2004 and 2014.
It may seem ready for usage but if you take a closer look, 
you will find several problems:

1. There are symbols like "-" which represents an absent value. However this will be treated as string, not as a number so you need to convert this to 0
2. There are reduntant lines e.g. 3 row "v tom" which only means "wwithin"
3. Some countries has so low numbers of immigrants that they are useless for vizualization
4. All records are together, but the first half is from EU countries and the second one from non EU countries

So how to fix that? We do not want to go column by column and fix the issues by hand. We want to that automatically. Lets use Ruby for that!
We will need to do:

1. read the .xls file into Ruby
2. Convert all empty strings and "-" into 0
3. Filter only countries which has some significant amount of imigrants (lets say above 10 000)
4. Group the data based on their type (total statistics, EU, non EU)
5. Count the sums for all the years together (they may come handy)
6. Write the results in some format which fits our needs - CSV in this case, because I will be doing visualizations in Excel

Here is the code that does that:

```ruby
  require "spreadsheet"
  require "pry"

  Spreadsheet.client_encoding = "UTF-8"

  # TASK 1
  data = Spreadsheet.open "imigranti.xls"

  final_data = []
  eu = []
  non_eu = []
  totals = []

  counter = 0

  data.worksheets[0].each 6 do |row|
    row = row.compact
    sum = 0

    break if row.size < 10

    # TASK 4 - we know that after 29 entry there will come non EU countries
    if counter <= 29
      row[0] = "EU " + row[0]
    elsif counter > 29
      row[0] = "NON " + row[0]
    end

    counter += 1

    row[1..-1].each do |item|
      # TASK 2
      item = 0 if item == "-" || item == " " || item == "."
      # TASK 5
      sum += item
    end

    # TASK 3
    if sum > 10000

      # TASK 4 again
      if row[0].include?("elkem")
        row[0] = row[0][3..-1]
        totals << [row, sum].flatten
        final_data << [row, sum].flatten
      end

      # TASK 4 again
      if row[0].include?("EU") && !row[0].include?("elkem")
        row[0] = row[0][3..-1]
        eu << [row, sum].flatten
        final_data << [row, sum].flatten
      end

      # TASK 4 again
      if row[0].include?("NON") && !row[0].include?("elkem")
        row[0] = row[0][4..-1]
        non_eu << [row, sum].flatten
        final_data << [row, sum].flatten
      end
    end
  end

  # TASK 6 
  puts totals.map {|x| x.join(",") }.join("\n")
  puts
  puts eu.map {|x| x.join(",") }.join("\n")
  puts
  puts non_eu.map {|x| x.join(",") }.join("\n")
  puts
```

And the resulting visualizations were just the results of a few clicks in Excel ...
(Next time look forward visualizations in d3)

![chart1](images/chart1.png)
![chart1](images/chart2.png)
![chart1](images/chart3.png)


