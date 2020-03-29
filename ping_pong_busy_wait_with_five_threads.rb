# Ping pong busy-wait implementation with five threads
# for each ping and pong to illustrate the need for mutex
#
# 1. create five threads each for ping and pong
# 2. print ping and pong alternatively
#
# NOTE: this is not thread safe, because for any thread
# the system scheduler could schedule another thread after
# a "ping" or "pong" without switching the mutex. 

threads = []
mutex = true

# ping threads
5.times do |id|
  threads << Thread.new do
    loop do
      if mutex
        # puts "#{Thread.current.__id__}: ping"
        puts "\##{id} ping"
        mutex = !mutex
      end
    end
  end
end

# ping threads
5.times do |id|
  threads << Thread.new do
    loop do
      if not mutex
        # puts "#{Thread.current.__id__}: pong"
        puts "\##{id}: pong"
        mutex = !mutex
      end
    end
  end
end

# NOTE: sleep blocks main thread and allows ping and pong threads to finish
sleep(5)
# threads.each(&:join)
