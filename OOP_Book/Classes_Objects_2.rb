# Exercises at the end of chapter


class MyCar
  attr_accessor :color
  attr_reader :year

  def self.gas_mileage(gallons, miles)   # class method, hence self
    "#{miles / gallons} miles per gallon of gas"
  end

  def spray_paint(color)
    self.color = color
    "Your car is now #{color}!"
  end
    
  
  def initialize(year, model, color)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end

  def speed_up(mph)
    @current_speed += mph
    "You push the gas and accelerate #{mph} mph."
  end

  def brake(mph)
    @current_speed -= mph
    "You push the brake and decelerate #{mph} mph."
  end

  def shut_off_car
    @current_speed = 0
    "Time to park the car!"
  end

  def current_speed
    "You are currently going #{@current_speed} mph!"
  end

  def to_s
    "Your #{self.color} #{self.year} #{@model} is a force to be reckoned with."
  end
end