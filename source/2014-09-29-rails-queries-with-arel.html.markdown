---
title: Rails queries with Arel
date: 2014-09-29 20:08 UTC
tags: rails, ruby, programming
layout: post
---

This article is focusing on basics of building up queries in Rails. What is a query? Well, we can imagine that as a question
to our database which gets us some subset of what is stored there. When we do `Model.first` or `Model.all` we are building up a simple queries.
But what if you want something more complex and possible something involving more than one model? 

Well, there are several ways how to get such results from your database.
First and probably most well known is to combine Active Record methods with pure SQL in strings for a specific and difficult parts. 
I will soon discuss why that is not always ideal solution and I will present the alternative way using Arel library.
Oh and of course there is also the "beginners" way how to get desirable data - you can use only Ruby to filter what has been returned by simple queries like `.all`.
This is really slow and ineffective as will be also described.

Lets say we have two tables `tasks` and `solutions` and we want to join them, group them based on their relationship
and then select task title and the count of that task belonging solutions. 
We want to end up with a simple table like this:

```
"Abandoned Island",1
"I am so grateful",8
"Describe your relationship",11
"Your fear",17
"Write something about you!",1
"My new professions",8
"What makes you smile",6
```

A complete beginner, like me few months ago, would say: "hey, that's easy. We will get all tasks, all solutions and then we will somehow 
get what we need". This could look like:

```ruby
result = {}
Task.each do |task|
   all_solutions = Solution.where(task_id: task.id)
   result[:task] = all_solutions.count
end
```
Or even worse, someone could decide to use `filter` instead of `where`. It is really not hard to see that this is the completely wrong way. We are pulling **all** the tasks into memory and then we are looking
at each task and pulling all his solutions only to in the end we would count the desirable count and produce a final Hash. For this purpose
we have the database abstraction - `Active Record` - to do the hard stuff. We should keep Ruby methods away from database queries as much as it is possible.

So what are these database methods which we can use? Of course there is `where`, but that is usually not enough. Now it is time for the 
promised SQL in the string. To compose the previous example we could do something like this:

```ruby
Task.joins(:solutions).group("tasks.id").select("tasks.title, count(solutions.id)")
```

The part in the string `"tasks.title, count(solutions.id)"` is the **pure SQL** which doesn't have anything in common with the rest of the code.
It is **embedding a different language** into Ruby just for this little part.
Well, we helped ourselves significantly in compared to the `each` variant. But this is still far from perfect.

Why?

- We need to know the syntax of our database language, in this case SQL. If we switched database, we would have to rewrite this part.
- It is not very object oriented way how to write code, you can not e.g. chain methods together
- You do not have any syntax check inside of the string

And here come the third option - **Arel**. Arel is a library which helps us to construct queries. It is used by `Active Record` to construct
queries, so everytime you do `where` or `limit` or `first`, you essentially use Arel. 
But there is more to that - we can exchange Arel methods for that ugly SQL strings we saw before. 

The previous example from previous could be written as:

```ruby
Task.joins(:solutions).group("tasks.id").select(Task.arel_table["title"], Solution.arel_table["id"].count)
```

Every Rails model has a method called `arel_table` which allows us to get information about a table or a column on that belonging table by using Hash syntax. 
We can see what is returned by `arel_table` in this example:

```ruby
pry(main)> User.arel_table

=> #<Arel::Table:0x007ff9f39ab718
 @aliases=[],
 @columns=nil,
 @engine=
  User(id: integer, email: string, encrypted_password: string, reset_password_token: string, reset_password_sent_at: datetime, remember_created_at: datetime, sign_in_count: integer, current_sign_in_at: datetime, last_sign_in_at: datetime, current_sign_in_ip: string, last_sign_in_ip: string, created_at: datetime, updated_at: datetime, admin: boolean, authentication_token: string, uid: string, provider: string),
 @name="users",
 @primary_key=nil,
 @table_alias=nil>
 ```
 
 This is used in building up queries. Arel is in the end writing the SQL queries for us.To find out which SQL is produced we can write
 
  ```ruby
  .to_sql
  ```
  
 in the end of our query and immediately get the raw SQL. 
 Anyway, we can see that it is much more object oriented, we can chain queries, we can call methods as `count` on them, 
 we can reuse them better and store parts in variables..
  
 Ok, so what else can we do with `arel_table` ? We can build predicates very easily, like:
 
  
  ```ruby
  Model.arel_table[:id].eq(1)
  Model.arel_table[:id].not_eq(1)
  Model.arel_table[:id].in([1,2])
  Model.arel_table[:id].not_in([1,2])
  ```
  
  There is another advantage of using Arel instead of row SQL. We do not have to use the hideous *question marks* to match arguments, check out this last example:

  ```ruby
  # SQL question marks
  .where("title" = ? AND is_active = ?", "Love", true)
  
  # Arel!
  .where(Task.arel_table["title"].eq("Love").and(Task.arel_table[:is_active].eq(true))
  ```
  
  If you want to dive deeply into Arel, I recommend this <a href="http://www.confreaks.com/videos/3332-railsconf-advanced-arel-when-activerecord-just-isn-t-enough">video</a> and these articles <a href="http://jpospisil.com/2014/06/16/the-definitive-guide-to-arel-the-sql-manager-for-ruby.html">I</a> and <a href="http://pivotallabs.com/using-arel-to-build-complex-sql-expressions/">II</a>. 