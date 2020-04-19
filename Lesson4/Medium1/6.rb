# FIRST METHOD

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

# SECOND METHOD

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

# on lines 11 and 25, they're basically the same
# just two different ways to access the getter method

# on lines 7 and 21, though, it's different
# on line 7, we're accessing the instance variable directly
# on line 21, we're accessing the value through the getter method
# that was set up on line 18 (or 4)

# Because we should avoid self when unnecessary, the first example is better