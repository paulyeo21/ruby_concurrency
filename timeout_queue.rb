# Implement a blocking queue that raises a TimeoutException when
# a blocking operation exceeds timeout interval.
#
# Blocking queue should:
# * blocking pop should return element if not empty
# * non-blocking pop should element if not empty
# * blocking pop should block if empty
# * non-blocking pop should raise Exception if empty

TIMEOUT_INTERVAL = 3

class TimeoutQueue
  def initialize
    @queue = []
    @mutex = Mutex.new
    @cv = ConditionVariable.new
  end

  def <<(element)
    @mutex.synchronize do
      @queue << element
      @cv.signal
    end
  end

  def pop(blocking=true)
    @mutex.synchronize do
      if blocking
        start_time = Time.now.to_f
        while @queue.empty? && start_time + TIMEOUT_INTERVAL > Time.now.to_f
          remaining_time = Time.now.to_f - start_time + TIMEOUT_INTERVAL
          @cv.wait(@mutex, remaining_time)
        end
      end

      raise RuntimeError, 'Nothing to pop' if @queue.empty?
      @queue.pop
    end
  end
end

queue = TimeoutQueue.new

# threads = []
#
# threads << Thread.new do
#   while true
#     puts "Thread A: #{queue.pop}"
#     sleep(1)
#   end
# end

# threads << Thread.new do
#   while true
#     puts "Thread B: #{queue.pop}"
#     sleep(1)
#   end
# end

# threads << Thread.new do
#   while true
#     puts "Thread C: #{queue.pop}"
#     sleep(1)
#   end
# end

# numbers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]
# numbers.each {|num| queue << num}
# sleep(5)

# blocking pop should return element if not empty
queue << 1
puts queue.pop == 1

# non-blocking pop should element if not empty
queue << 2
puts queue.pop(false) == 2

# blocking pop should block if empty
Thread.new { sleep(5); queue << 3 }
puts queue.pop == 3

# non-blocking pop should raise Exception if empty
# puts queue.pop(false) # raises Exception

# blocking pop should block only for TIMEOUT_INTERVAL if empty
puts queue.pop # raises Exception after TIMEOUT_INTERVAL expires

