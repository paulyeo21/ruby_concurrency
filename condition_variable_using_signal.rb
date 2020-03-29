# Implement an example of using Ruby's condition variable. 

resource = ConditionVariable.new
mutex = Mutex.new

thread = Thread.new do
  mutex.synchronize do
    resource.wait(mutex) 
    puts 'Child thread'
  end
end

sleep(1)
resource.signal
sleep(1)

puts 'Main thread'
