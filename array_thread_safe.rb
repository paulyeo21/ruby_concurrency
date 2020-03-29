# Implement a thread-safe program that updates an array of boolean
# values continuosly and outputs the values.

mutex = Mutex.new
array = [true, true]

writer = Thread.new do
  loop do
    mutex.synchronize do
      # NOTE: not thread-safe, because updates are not atomic
      array[0] = !array[0]
      array[1] = !array[1]
    end
  end
end

reader = Thread.new do
  loop do
    mutex.synchronize { puts array.inspect }
  end
end

sleep(5)
