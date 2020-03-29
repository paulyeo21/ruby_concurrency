# Implement ping pong program using a condition variable with 5 threads each

mutex = Mutex.new
resource = ConditionVariable.new
ping = true

5.times do |id|
  Thread.new do
    loop do
      mutex.synchronize do
        while not ping
          resource.wait(mutex)
        end

        puts "#{id}: ping"
        ping = !ping
        resource.broadcast
      end
    end
  end
end

5.times do |id|
  Thread.new do
    loop do
      mutex.synchronize do
        while ping
          resource.wait(mutex)
        end

        puts "#{id}: pong"
        ping = !ping
        resource.broadcast
      end
    end
  end
end

sleep(5)
