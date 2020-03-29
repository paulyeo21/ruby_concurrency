# Implement ping pong with multiple threads (five each)
# using a mutex to make it thread-safe.

mutex = Mutex.new
ping = true

# ping threads
5.times do |id|
  Thread.new do
    loop do
      mutex.lock # attempts to grab lock and waits if it isn't available
      if ping
        puts "\##{id}: ping"
        ping = !ping
      end
      mutex.unlock
    end
  end
end

# pong threads
5.times do |id|
  Thread.new do
    loop do
      mutex.lock # attempts to grab lock and waits if it isn't available
      if not ping
        puts "\##{id}: pong"
        ping = !ping
      end
      mutex.unlock
    end
  end
end

# NOTE: sleep blocks main thread and allows ping and pong threads to finish
sleep(5)
