## example of a thread that doesn't finish before main thread exits

t1 = Thread.new do
  sleep(60 * 60 * 24)
  puts 'Child thread exiting' # this would never be called
end

puts 'Main thread exiting'

##
# Thread.kill(t1)
# t1.exit()
