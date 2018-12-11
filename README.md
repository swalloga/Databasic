# Databasic

###How to use:
1. Clone this repo
2. Run ``rake db:create``
3. Run ``$ ruby databasic.rb``

###Summary:

Databasic is a lightweight Object Relational Mapping tool, which I built to deepen my understanding of ActiveRecord.
After spending years manipulating data in excel, I wanted to dive deeper into the connections between the object oriented models of Ruby and their corresponding tables in a SQL database.

###Usage:
open database connection
run rake db:create to auto-generate a seeded database

Next, define a model:

By defining ``my_attr_accessor``, we allow mass-assignment:

The ``foreign_key`` for ``has_many :cats`` would have been guessed to be ``:person_id``.
This isn't the naming we want, so our ``has_many`` and ``belongs_to`` associations allow overrides for ``:class_name``, ``:foreign_key``, and `:primary_key`:

In this example, the table name ``"persons"`` will be inferred. To override the default, call ``set_table_name "new_name"``:

Last, there is support for ``has_one_through``:
