## ping pong example using mutex

$flag = true
m1 = Mutex.new
pings = []
pongs = []

pings = 5.times.map do |i|
  Thread.new(i) do |arg|
    while true
      m1.lock()
      while $flag == false
        m1.unlock()
        m1.lock()
      end

      puts "ping #{arg}"
      sleep(0.01)
      $flag = false
      m1.unlock()
    end
  end
end

pongs = 5.times.map do |i|
  Thread.new(i) do |arg|
    while true
      m1.lock()
      while $flag == true
        m1.unlock()
        m1.lock()
      end

      puts "pong #{arg}"
      sleep(0.01)
      $flag = true
      m1.unlock()
    end
  end
end

sleep(10)
