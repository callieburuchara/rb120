# Exercises at the end of chapter
module Packable
  'It can hold SO MUCH STUFF in the trunk!'
end

class Vehicle
  
  @@amount_of_vehicles = 0

  def initialize(year, model, color)
    @@amount_of_vehicles += 1
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end

  def self.gas_mileage(gallons, miles)   # class method, hence self
    "#{miles / gallons} miles per gallon of gas"
  end
  
  def speed_up(mph)
    @current_speed += mph
    "You push the gas and accelerate #{mph} mph."
  end

  def brake(mph)
    @current_speed -= mph
    "You push the brake and decelerate #{mph} mph."
  end

  def shut_off
    @current_speed = 0
    "Time to park!"
  end

  def current_speed
    "You are currently going #{@current_speed} mph!"
  end

  def self.amount_of_vehicles
    "I currently have #{@@amount_of_vehicles} on the road!"
  end

  attr_accessor :color
  attr_reader :year

  def spray_paint(color)
    self.color = color
    "Your ride is now #{color}!"
  end

  private

  def age
    years = Time.now.year - self.year
    "Your #{@model} is #{years} years old."
  end
end


class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s
    "Your #{self.color} #{self.year} #{@model} is a great car, a force to be reckoned with."
  end
end


class MyTruck < Vehicle
  include Packable
  NUMBER_OF_DOORS = 2
  def to_s
    "Your #{self.color} #{self.year} #{@model} is a great truck, a force to be reckoned with."
  end
end

truck = MyTruck.new(1992, 'Toyota', 'black')
car = MyCar.new(1993, 'Nissan', 'blue')

puts truck.age
puts car