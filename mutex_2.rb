## mutex sharing with one child example

m1 = Mutex.new

Thread.new do
  puts 'Child thread acquiring mutex'
  m1.lock()
  sleep(3)
  puts 'Child thread releasing mutex'
  m1.unlock()
end

sleep(1)
puts 'Main thread attempting to acquire mutex'
m1.lock()
puts 'Main thread acquires mutex'
m1.unlock()
