# Busy wait version of ping pong implementation

# two threads
# when one thread gets access to the mutex, write ping or pong and release resource

mutex = true
alive = true

# thread 1
ping_thread = Thread.new do
  while alive
    if mutex
      puts 'ping'
      mutex = !mutex
      # note: this is not thread-safe
      # mutex = !mutex
      # puts 'ping'
    end
  end
end

# thread 2
pong_thread = Thread.new do
  while alive
    if not mutex
      puts 'pong'
      mutex = !mutex
      # note: this is not thread-safe
      # mutex = !mutex
      # puts 'pong'
    end
  end
end

sleep(2)
alive = false
ping_thread.join
pong_thread.join

