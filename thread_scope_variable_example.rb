## example of thread scope variable in ruby

threads = 5.times.map do
  Thread.new do
    sleep(0.5)
    id = Thread.current.thread_variable_get('id')
    # id = Thread.current[:id]
    puts "Thread with #{id} exiting"
  end
end

5.times {|i| threads[i].thread_variable_set('id', i)}
# 5.times do |i|
#   thread = threads[i]
#   thread[:id] = i
# end

threads.each(&:join)
