# Busy wait version of ping pong implementation

# two threads
# when one thread gets access to the mutex, write ping or pong and release resource

mutex = true

# thread 1
ping_thread = Thread.new do
  loop do
    # until mutex
    # end

    if mutex
      puts 'ping'
      mutex = !mutex
      # note: the following is not thread-safe
      # mutex = !mutex
      # puts 'ping'
    end
  end
end

# thread 2
pong_thread = Thread.new do
  loop do
    # until not mutex
    # end

    if not mutex
      puts 'pong'
      mutex = !mutex
      # note: the following is not thread-safe
      # mutex = !mutex
      # puts 'pong'
    end
  end
end

# NOTE: sleep blocks main thread and allows ping and pong threads to finish
sleep(5)
# ping_thread.join
# pong_thread.join
