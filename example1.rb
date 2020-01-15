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

  t1 = Thread.new do
    s1.add()
  end

  t2 = Thread.new do
    s2.add()
  end

  t1.join()
  t2.join()
  s1.current + s2.current
end

def doubleProcesses
  r1, w1 = IO.pipe
  r2, w2 = IO.pipe

  pid1 = Process.fork do
    s = SumUp.new(1, MAX_NUM / 2)
    s.add()
    w1.puts s.current
  end

  pid2 = Process.fork do
    s = SumUp.new(MAX_NUM / 2 + 1, MAX_NUM)
    s.add()
    w2.puts s.current
  end

  Process.wait pid1
  Process.wait pid2

  w1.close()
  w2.close()
  r1.read().to_i + r2.read().to_i
end

starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
sum = singleThread()
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Single thread: #{ending - starting} to sum up to #{sum}"

starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
sum = doubleThread()
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Double thread: #{ending - starting} to sum up to #{sum}"

starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
sum = doubleProcesses()
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Double processes: #{ending - starting} to sum up to #{sum}"

