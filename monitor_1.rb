## monitor example

monitor = Monitor.new
monitor.enter()
monitor.enter()
puts 'I am a reentrant'
monitor.enter()
monitor.enter()
