# Implement a blocking queue (or otherwise called a bounded buffer or consumer producer) using a semaphore.
#
# - Blocking queue is a thread-safe queue that implements #set and #get which correspond to setting an element in the queue and getting an element from the queue. The elements should be removed in FILO order and a get call should be blocked if there are no elements in the queue.
#
# - Specs
# * Queue should block if #get and there are no elements
# * Queue should not block if #get and there are elements

class BlockingQueue
  def initialize
    @queue = []
    @monitor = Monitor.new
    @cond = @monitor.new_cond
  end

  def set(element)
    @monitor.synchronize do
      @queue << element
      @cond.broadcast
    end
  end

  def get
    @monitor.synchronize do
      while @queue.empty?
        @cond.wait
      end
      @queue.pop
    end
  end
end

q = BlockingQueue.new

t1 = Thread.new do
  q.set('a')
  puts 'Thread 1 set "a"'
end

t2 = Thread.new do
  q.set('b')
  puts 'Thread 2 set "b"'
end

t3 = Thread.new do
  puts "Thread 3 got #{q.get}"
end

t4 = Thread.new do
  puts "Thread 4 got #{q.get}"
end

[t1, t2, t3].each(&:join)
