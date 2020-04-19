class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    "I want to turn on the light with a brightness level of super high and a colour of green"
  end

end

# changed to self.information from light_information
# because it will be called on Light, so that will be clear. 