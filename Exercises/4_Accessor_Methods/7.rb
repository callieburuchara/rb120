class Person
  attr_reader :name

  def name=(input)
    @name = 'Mr. ' + input
  end
end

person1 = Person.new
person1.name = 'James'
puts person1.name


# Another way to do it:

class Person
  attr_writer :name

  def name
    "Mr. #{@name}"
  end
end