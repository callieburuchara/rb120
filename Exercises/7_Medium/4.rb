=begin
CIRCULAR QUEUE
- collection of objects stored in a buffer in the form of a circle
- ADD object: added in the position right after the last added object
- REMOVE object: removes object that has been there the longest
-can add without issue if there are blank spots
-if queue is full, automatically remove one in order to add one




=end

class CircularQueue
  attr_accessor :queue 
  
  def initialize(num)
    @max_size = num
    @queue = []
  end

  def enqueue(num)
    if queue.size == @max_size
      dequeue
      queue << num
    else
      queue << num
    end
  end

  def dequeue
    queue.shift
  end
end


queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil