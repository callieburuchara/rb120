class BigCat

  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

fluffy = BigCat.new('Lucy')
fluffy.name = 'Floofy'
puts fluffy.name
#=> Floofy