## mutex for race condition test-then-act example

$rand = rand(1..100)
mutex = Mutex.new

t1 = Thread.new do
  while true
    mutex.synchronize {
      if $rand % 5 == 0
        puts "#{$rand} is divisible by 5"

        if $rand % 5 != 0
          puts "#{$rand} is not divisible by 5"
        end
      end
    }
  end
end

t2 = Thread.new do
  mutex.synchronize {
    while true
      $rand = rand(1..100)
    end
  }
end

sleep(10)
