## Multi-threaded example of a ping pong game

$running = true
$flag = true

t1 = Thread.new do
  while $running
    while $flag == true
      # wait
    end

    puts 'ping'
    $flag = true
    ## if these two lines above were swapped, then it could cause a seemingly innocuous
    #  but dangerous bug. say a 'pong' output occurs. the OS schedule switches to
    #  the first thread and sets $flag to true. Before printing 'ping' the OS scheduler 
    #  could switch to the second thread and lead to a consecutive 'pong' output.
  end
end

t2 = Thread.new do
  while $running
    while $flag == false
      # wait
    end

    puts 'pong'
    $flag = false
  end
end

sleep(10)
$running = false
t1.join()
t2.join()
