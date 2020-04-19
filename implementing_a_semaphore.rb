# Implement a semaphore without using Ruby's concurrent gem
#
# -- A semaphore is a construct that allows some threads to access a fixed set of resources in parallel. Always think of a semaphore as having a fixed number of permits to give out. Once all the permits are given out, requesting threads need to wait for a permit to be returned before proceeding forward.
# 
# -- Specs:
# * Allow a set maximum number of permits.
# * Block #acquire until a permit is available.
# * #release adds a permit, potentially releasing a blocking acquirer.

class Semaphore
  def initialize(num_permits)
    @num_permits = num_permits
    @monitor = Monitor.new
    @cond = @monitor.new_cond
  end

  def acquire
    @monitor.synchronize do
      while @num_permits == 0
        @cond.wait
      end
      # @cond.broadcast
      @num_permits -= 1
    end
  end

  def release
    @monitor.synchronize do
      while @num_permits != 0
        @cond.wait
      end
      @cond.broadcast
      @num_permits += 1
    end
  end
end

semaphore = Semaphore.new(2)

t1 = Thread.new do
  semaphore.acquire
  puts 'Thread 1 acquired semaphore'
end

t2 = Thread.new do
  semaphore.acquire
  puts 'Thread 2 acquired semaphore'
end

t3 = Thread.new do
  semaphore.acquire
  puts 'Thread 3 acquired semaphore'
end

t4 = Thread.new do
  sleep(1)
  semaphore.release
  puts 'Thread 4 releasing semaphore'
end

[t1, t2, t3, t4].each(&:join)

