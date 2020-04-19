module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

# self.class enables us to access the name of the
# class of the object that is passed in
# `self` refers to the object itself
# then class gets us the class
# also, to_s is implied with the string interpolation