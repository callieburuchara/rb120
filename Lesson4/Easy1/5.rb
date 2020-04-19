class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# @name is an instance variable because of the @

orange = Fruit.new('orange')
pineapple = Pizza.new('pineapple')

p orange.instance_variables
p pineapple.instance_variables