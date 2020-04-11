class Cat
  @@cats_amount = 0

  def initialize
    @@cats_amount += 1
  end

  def self.total
    puts @@cats_amount
  end
end


kitty1 = Cat.new
kitty2 = Cat.new

Cat.total