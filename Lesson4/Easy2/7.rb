class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# @@cats_count keeps track of how many objects of Cat
# are initialized (because it adds one in the initialize
# instance method)
# We can test this by creating a few objects and then
# calling the self.cats_count on the Cat class.

fluffy = Cat.new("ragdoll")
p Cat.cats_count
floofy = Cat.new("ragdoll")
p Cat.cats_count
sleepy = Cat.new("ragdoll")
p Cat.cats_count