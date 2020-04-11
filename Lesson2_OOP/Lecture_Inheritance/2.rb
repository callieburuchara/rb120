class Animal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Animal
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Animal
  def speak
    'meow!'
  end
end

pete = Animal.new
kitty = Cat.new
dave = Dog.new

p pete.run                # => "running!"
#p pete.speak              # => NoMethodError

p kitty.run               # => "running!"
p kitty.speak             # => "meow!"
#p kitty.fetch             # => NoMethodError

p dave.speak              # => "bark!"