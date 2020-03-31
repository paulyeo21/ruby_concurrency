# Implement a thread-safe program that updates a running count using a monitor.

# 1. Create class that updates count in memory
# 2. Create many threads that update to the count using a monitor.

class Counter
  include MonitorMixin

  attr_reader :count

  def initialize(*args)
    @count = 0
    super(*args)
  end

  def increase
    self.synchronize do
      @count += 1
    end
  end
end

threads = []
counter = Counter.new

10.times do |id|
  threads << Thread.new do
    loop do
      puts "(\##{id}) Before: #{counter.count}"
      counter.increase
      puts "(\##{id}) After: #{counter.count}"
      puts
      sleep(1)
    end
  end
end

threads.each(&:join)
