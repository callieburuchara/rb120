class Transform
  def initialize(letters)
    @my_data = letters
  end

  def uppercase
    @my_data.upcase
  end

  def self.lowercase(letters)
    letters.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')
