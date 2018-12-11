# Databasic

### How to use:
* Clone this repo
* Run ``rake db:create``
* Run ``$ ruby databasic.rb``

### Summary:

Databasic is a lightweight Object-Relational Mapping tool that allows you to query and manipulate data from a database using an object-oriented paradigm, which I built to deepen my understanding of ActiveRecord.  

After spending years manipulating data in excel, I wanted to dive deeper into the connections between the object oriented models of Ruby and their corresponding tables in a SQL database.

### Usage:
Open database connection  
Run rake db:create to auto-generate a seeded database

Next, define a model:

``my_attr_accessor``

The ``foreign_key`` for ``has_many :cats`` would have been guessed to be ``:person_id``.
This isn't the naming we want, so our ``has_many`` and ``belongs_to`` associations allow overrides for ``:class_name``, ``:foreign_key``, and `:primary_key`:

In this example, the table name ``"persons"`` will be inferred. To override the default, call ``set_table_name "new_name"``:

There is also support for ``has_one_through``:
