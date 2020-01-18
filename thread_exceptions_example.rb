## Example of a thread raising an exception

t1 = Thread.new do
  puts 'Child thread about to raise exception'

  raise 'Ka Boom!'

  puts 'Child thread exiting' # Never gets called
end

sleep(1)
puts "Child thread status #{t1.status}"
puts 'Main thread exiting'

## in the above example, the child thread does not affect the main thread
#  by raising an exception. With a t1.join(), the exception is propagated
#  to the main thread, which exits with a runtime error. 

Thread.abort_on_exception = true

t2 = Thread.new do
  puts 'Child thread about to raise exception'

  raise 'Ka Boom!'

  puts 'Child thread exiting' # Never gets called
end

begin
  sleep(1)
  puts 'Main thread exiting peacefully'
rescue RuntimeError => e
  puts e.to_s
end
