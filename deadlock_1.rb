## deadlock example

m1 = Mutex.new
m2 = Mutex.new

t1 = Thread.new do
  puts 'Acquiring mutex 1'
  m1.lock()
  sleep(1)
  m2.lock()
  puts 'Thread 1 exiting'
end

t2 = Thread.new do
  puts 'Acquiring mutex 2'
  m2.lock()
  sleep(1)
  m1.lock()
  puts 'Thread 2 exiting'
end

t1.join()
t2.join()

# deadlock occurs because after t1 locks m1, the scheduler
# switches to t2 to lock m2 which results in both resources
# occupied but neither thread able to proceed.
