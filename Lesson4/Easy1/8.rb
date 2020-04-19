class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# make_one_year_older is an instance method
# so it can only be used on instances (objects)
# therefore, self here refers to the object that
# it is called on