# Sample using multiple threads

threads = []
threads << Thread.new { puts 'a' }
threads << Thread.new { puts 'b' }
threads << Thread.new { puts 'c' }

# NOTE: this will not necessarily print in order
threads.each(&:join)
