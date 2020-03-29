# Implement a ruby queue that implements the methods set, non-blocking get, and
# blocking get.

class SimpleQueue
  def initialize
    @queue = []
    @mutex = Mutex.new
  end

  def <<(item)
    @mutex.synchronize { @queue << item }
  end

  def shift(blocking = true)
    @mutex.synchronize { @queue.shift }
  end
end

q = SimpleQueue.new
q << 'a'
puts q.shift
puts q.shift
