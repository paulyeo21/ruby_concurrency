## Multi-threading example timing one thread, two threads, and two proccesses in Ruby

MAX_NUM = 3000000

class SumUp
  attr_reader :current, :starting, :ending

  def initialize(starting, ending)
    @current = 0
    @starting = starting
    @ending = ending
  end

  def add
    (@starting..@ending).each do |i|
      @current += i
    end
  end
end

def singleThread
  s = SumUp.new(1, MAX_NUM)
  thread = Thread.new do
    s.add()
  end
  thread.join()
  s.current
end

def doubleThread
  s1 = SumUp.new(1, MAX_NUM / 2)
  s2 = SumUp.new(MAX_NUM / 2 + 1, MAX_NUM)
end

starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
sum = singleThread()
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Single thread: #{ending - starting} to sum up to #{sum}"

