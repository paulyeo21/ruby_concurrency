# Implement two threads, one writer and one reader. The writer
# thread flips the values of an array of booleans, while the reader
# outputs the value. This example illustrates how it is not thread-safe,
# because the array is not updated atomically, which means that the
# system scheduler can schedule the reader thread to read a partially
# updated array (such as [false, true] or [true, false]).

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
    puts array.inspect
  end
end

sleep(5)
