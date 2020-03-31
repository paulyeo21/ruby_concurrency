# Implement a thread-safe queue. Implement the methods set and get as well as a
# blocking get. A blocking get refers to blocking the threads that try to 
# set or get elements from the queue. For instance, if there is a thread
# that is trying to get an element from a queue that is empty, the thread can be
# blocked until there is an element to get. 

# 1. implement thread-safe methods set and get (without blocking).
# 2. blocking means that if a thread tries a get on an empty queue,
#    wait until queue is not empty. We can use a condition variable
#    and the condition queue.empty?.

class SimpleQueue
  def initialize
    @queue = []
    @mutex = Mutex.new
    @cv = ConditionVariable.new
  end

  def <<(item)
    @mutex.synchronize do
      @queue << item
      @cv.signal
    end
  end

  def shift(blocking = true)
    @mutex.synchronize do
      if blocking
        while @queue.empty?
          @cv.wait(@mutex)
        end
      end
      @queue.shift
    end
  end
end

q = SimpleQueue.new

threads = []
threads << Thread.new do
  puts "Blocking shift returned with: #{q.shift}"
end
threads << Thread.new do
  sleep(5)
  q << 'foo'
end
threads << Thread.new do
  puts "Non-blocking shift returned with: #{q.shift(false)}"
end

threads.each(&:join)
