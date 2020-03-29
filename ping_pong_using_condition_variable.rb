# Implement ping pong program using a condition variable

mutex = Mutex.new
resource = ConditionVariable.new
ping = true

Thread.new do
  loop do
    mutex.synchronize do
      while not ping
        resource.wait(mutex)
      end

      puts 'ping'
      ping = !ping
      resource.signal
    end
  end
end

Thread.new do
  loop do
    mutex.synchronize do
      while ping
        resource.wait(mutex)
      end

      puts 'pong'
      ping = !ping
      resource.signal
    end
  end
end

sleep(5)
