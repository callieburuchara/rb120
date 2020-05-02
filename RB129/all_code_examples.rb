#instantiating an object (simple)

class BigCat
end

fluffy = BigCat.new
puts fluffy
# => #<BigCat:0x00007f879b8677f0>

#-------------------------------------------------------------------

# Using a getter method to access a local variable

class BigCat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "My name is #{name}"
  end
end

fluffy = BigCat.new('Lucy')
puts fluffy
# => "My name is Lucy"


# DIFFERENCE of attr_* METHODS

# attr_reader
class BigCat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "My name is #{name}"
  end
end

fluffy = BigCat.new('Lucy')
puts fluffy
puts fluffy.name
fluffy.name = 'Susie'
# => "My name is Lucy"
# => "Lucy"
# => undefined method `name=` (NoMethodError)

# attr_writer
class BigCat
  attr_writer :name

  def initialize(name)
    @name = name
  end

  def to_s
    "My name is #{@name}" # We made this into an instance variable instead of getter method
  end
end

fluffy = BigCat.new('Lucy')
puts fluffy
fluffy.name = 'Susie'
puts fluffy
puts fluffy.name
# => "My name is Lucy"
# => "My name is Susie"
# => undefined method `name' (NoMethodError)

# attr_accessor
class BigCat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def to_s
    "My name is #{name}"
  end
end

fluffy = BigCat.new('Lucy')
puts fluffy
fluffy.name = 'Susie'
puts fluffy
puts fluffy.name
# => "My name is Lucy"
# => "My name is Susie"
# => "Susie"

#-------------------------------------------------------------------

# how to use self to avoid creating a local variable

class MyCar

  attr_accessor :year, :color

  def initialize(year, color)
    @year = year
    @color = color
  end

  def update_color(new_color)
    self.color = new_color.downcase
    #instead of color = new_color
  end

  def to_s
    "My #{year} car is #{color}."
  end
end

cruiser = MyCar.new(1996, "yellow")
puts cruiser
cruiser.update_color("BLUE")
puts cruiser


#-------------------------------------------------------------------

# difference between using getter/setter methods or referencing instance variacles

#with instance variables
class Person
  def initialize(name, eye_color)
    @name = name
    @eye_color = eye_color
  end

  def to_s
    "My name is #{@name}, my eyes are #{@eye_color}."
  end

  def update_name(new_name)
    @name = new_name
  end
end

woman = Person.new('Ashley', 'blue')
woman.update_name('Ashleigh')
puts woman
#=> "My name is Ashleigh, and my eyes are blue.""

#with getter/setter methods
class Person
  attr_accessor :name
  attr_reader :eye_color
  
  def initialize(name, eye_color)
    @name = name
    @eye_color = eye_color
  end

  def to_s
    "My name is #{name}, my eyes are #{eye_color}."
  end
end

woman = Person.new('Ashley', 'blue')
woman.name = 'Ashleigh'
puts woman
#=> "My name is Ashleigh, and my eyes are blue.""

#-------------------------------------------------------------------

# class methods vs. instance methods

class Person
  attr_accessor :name
  attr_reader :eye_color

  @@amount_of_people = 0
  
  def initialize(name, eye_color)
    @name = name
    @eye_color = eye_color
    @@amount_of_people += 1
  end

  def to_s
    "My name is #{name}, and my eyes are #{eye_color}."
  end

  def self.amount_of_people
    @@amount_of_people
  end
end

woman = Person.new('Lucy', 'blue')
man = Person.new('Brian', 'green')
puts Person.amount_of_people
# => 2
p man.to_s 
# => "My name is Brian, and my eyes are green."

#-------------------------------------------------------------------

# class inheritance

class Human
  def greeting
    "Hi there!"
  end
end

class Man < Human
end

class Woman < Human
end

george = Man.new
jessica = Woman.new
puts george.greeting           
# => Hi there!
puts jessica.greeting             
# => Hi there!


# class inheritance, overriding a method

class Human
  def greeting
    "Hi there!"
  end
end

class Man < Human
  def greeting
    "Hey there!"
  end
end

class Woman < Human
end

george = Man.new
jessica = Woman.new
puts george.greeting           
# => Hey there!
puts jessica.greeting             
# => Hi there!

# class inheritance, altering using super

class Human
  def greeting
    "Hi there!"
  end
end

class Man < Human
  def greeting
    super + " How's the fam?"
  end
end

class Woman < Human
end

george = Man.new
jessica = Woman.new
puts george.greeting           
# => Hey there! How's the fam?
puts jessica.greeting             
# => Hi there!

#-------------------------------------------------------------------
# modules

module Runnable
  def run
    "I can run far!"
  end
end

class Horse
  include Runnable
end

class Marathoners
  include Runnable
end

walla = Horse.new
jessica = Marathoners.new
puts walla.run
puts jessica.run

#-------------------------------------------------------------------


# ducktyping

class Wedding
  attr_reader :guests, :flowers, :songs

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    #implementation
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding.flowers)
  end

  def decorate_place(flowers)
    # implementation
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end

  def prepare_performance(songs)
    #implementation
  end
end

#-------------------------------------------------------------------

# another ducktyping example

class Animal

  def speak(animals)
    animals.each do |animal|
      puts animal.speak
    end
  end
end

class Cat
  def speak
    'Meow!'
  end
end

class Dog
  def speak
    'Woof!'
  end
end

class Horse
  def speak
    'Neigh!'
  end
end

class Bird
  def speak
    'Tweet!'
  end
end

all_animals = [Cat.new, Dog.new, Horse.new, Bird.new]

animal = Animal.new

animal.speak(all_animals)


#-------------------------------------------------------------------

# protected method

class Cat
  
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def older?(other)
    age > other.age
  end
  
  private
  
  attr_reader :age

end

cat1 = Cat.new("Snowball", 10)
cat2 = Cat.new("Pumpkin", 11)

p cat2.older?(cat1) # true

#-------------------------------------------------------------------

# Method chain lookup 

module Runnable
  def run
    "I can run far!"
  end
end

module WinsMedals
end

class Human
end

class Horse
  include Runnable
  include WinsMedals
end

class Marathoners < Human
  include Runnable
  include WinsMedals
end

p Marathoners.ancestors

#-------------------------------------------------------------------

# collaborator objects with custom classes

class Person
  attr_accessor :pet
  
  def initialize(name)
    @name = name
  end

end

class Dog
  attr_reader :name
  
  def initialize(name)
    @name = name
  end

  def speak
    "Arf!"
  end
end

callie = Person.new('Callie')
callie.pet = Dog.new('Everest')
p callie.pet.speak
# => 'Arf!'
p callie.pet.class
# => Dog