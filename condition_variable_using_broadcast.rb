# Implement an example of using Ruby's condition variable with broadcast.

resource = ConditionVariable.new
mutex = Mutex.new

3.times do |id|
  Thread.new do
    mutex.synchronize do
      resource.wait(mutex)
      puts "\##{id}: Child thread"
    end
  end
end

sleep(1)
resource.broadcast
sleep(5)

puts 'Main thread'
