class Person
  def name=(full_name)
    separate = full_name.split(' ')
    @first_name = separate.first
    @last_name = separate.last
  end

  def name
    "#{@first_name} #{@last_name}"
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name


# Another solution

class Person
  def name=(name)
    @first_name, @last_name = name.split(' ')
  end

  def name
    "#{@first_name} #{@last_name}"
  end
end