## race condition test-then-act example

$rand = rand(1..100)

t1 = Thread.new do
  while true
    if $rand % 5 == 0
      puts "#{$rand} is divisible by 5"

      if $rand % 5 != 0
        puts "#{$rand} is not divisible by 5"
      end
    end
  end
end

t2 = Thread.new do
  while true
    $rand = rand(1..100)
  end
end

sleep(10)
