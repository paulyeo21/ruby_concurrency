# Implement the ping pong program using a monitor

monitor = Monitor.new
cv = monitor.new_cond
ping = true

ping = Thread.new do
  loop do
    monitor.synchronize do
      while not ping
        cv.wait
      end

      puts 'ping'
      sleep(1)
      ping = !ping
      cv.signal
    end
  end
end

pong = Thread.new do
  loop do
    monitor.synchronize do
      while ping
        cv.wait
      end

      puts 'pong'
      sleep(1)
      ping = !ping
      cv.signal
    end
  end
end

# NOTE: sleep blocks main thread and allows ping and pong threads to finish
# ping.join
# pong.join
sleep(5)
