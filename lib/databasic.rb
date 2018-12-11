require_relative 'sql_object'
require_relative 'searchable'
require_relative 'asscoiatable'
require_relative 'asscoiatable2'
require 'sqlite3'


show verbose queries
ENV['DEBUG'] = 'true'

# open database connection
DBConnection.open('../pets.db')

# define pet model
class Pet < SQLObject
 attr_accessor :id, :name, :owner_id

 belongs_to :person, foreign_key: :owner_id
 has_one_through :house, :person, :house
end

# define person model
class Person < SQLObject
 Person.table_name = 'people'
 attr_accessor :id, :fname, :lname, :house_id

 has_many :pets,
 foreign_key: :owner_id,
 class_name: :Pet,
 primary_key: :id

 belongs_to :house
end

# define house model
class House < SQLObject
 attr_accessor :id, :address

 # specify class_name, foreign_key, primary_key
 has_many :people,
   class_name: :Person,
   foreign_key: :house_id,
   primary_key: :id
end

puts 'simply find queries:'
puts '-------------------'
pet = Pet.find(2)
puts "pet = Pet.find(2)       => #{pet.inspect}"
puts "pet.name                => #{pet.name}"

puts

person = Person.find(1)
puts "person = Person.find(1)   => #{person.inspect}"
puts "person.fname             => #{person.fname}"

puts

puts 'belongs_to associations:'
puts '-----------------------'
puts "pet.person               => #{pet.person.inspect}"
puts "pet.person.fname:        => #{pet.person.fname}"
puts "person.house.address:    => #{person.house.address}"

puts

puts 'has_many associations:'
puts '---------------------'
puts "person.pets              => #{person.pets.inspect}"

puts

puts 'has_one_through associations:'
puts '----------------------------'
puts "pet.house               => #{pet.house.inspect}"
puts "pet.house.address:      => #{pet.house.address}"
