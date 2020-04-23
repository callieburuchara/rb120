class Machine
  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def to_s
    switch
  end
  
  private

  attr_writer :switch

  def switch
    @switch
  end

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

computer = Machine.new
p computer.start
p computer.stop
puts computer