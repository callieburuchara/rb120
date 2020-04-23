module FourLegged
  private
  def hello
    puts "Hello from Fourlegged!"
  end
end

class Animal
  
  private

  def greeting
    puts "Animal!"
  end
end

class Dog < Animal
  include FourLegged

  def greetingg
    hello
    greeting
    puts "Dog!"
  end

end

everest = Dog.new
p Dog.ancestors
