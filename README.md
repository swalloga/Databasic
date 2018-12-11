# Databasic

### Summary:

Databasic is a lightweight Object-Relational Mapping tool that allows you to query and manipulate data from a database using an object-oriented paradigm, which I built to deepen my understanding of ActiveRecord.  

After spending years manipulating data in excel, I wanted to dive deeper into the connections between the object oriented models of Ruby and their corresponding tables in a SQL database.


### How to demo this tool:
* Clone this repo
* Run `cat db/seeds.sql | sqlite3 pets.db`
* Run `ruby lib/databasic.rb`
Some example functionality will print to the terminal, try additional methods shown below using the sample pets database.


### How to use in your project:
Clone this repo and then `require 'databasic.rb'` in your file to gain access to the Databasic API methods.

Open a database connection by referencing your database file in a DBConnection() method.

Next, define a model on which to use the databasic API methods.


### Databasic API:

`self.column`  
`self.finalize!`  
`self.table_name=(table_name)`  
`self.table_name`  
`self.all`  
`self.parse_all(results)`  
`self.find(id)`  
`initialize(params = {})`  
`attributes`  
`attribute_values`  
`insert`  
`update`  
`save`  
`where`  
`model_class`  
`table_name`  
`belongs_to`  
`has_many`  
`has_one_through`

#### Comments:

The `foreign_key` for `has_many :pets` would have been defaulted to `:person_id` rather than `:owner_id`. This isn't the naming we want, so our associations allow overrides for `:class_name`, `:foreign_key`, and `:primary_key`. This is true for our `belongs_to` and `has_one_through` associations as well.

In my example database, the table name `"persons"` will be inferred from the `Person` class. To override the default, call `self.table_name = "table_name"`.
