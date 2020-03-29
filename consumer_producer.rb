# Implement a program that has producer threads that create tasks and a
# consumer thread that takes the queued list of tasks and processes them.
#

tasks = []
mutex = Mutex.new
condition_variable = ConditionVariable.new

class Task
  def initialize
    @duration = rand()
  end

  def process
    sleep(@duration)
  end
end

# consumer threads
2.times do
  Thread.new do
    loop do
      mutex.synchronize do
        tasks << Task.new
        condition_variable.signal
        puts 'Produced new task'
      end
      sleep(0.5) # create one task per sec
    end
  end
end

# producer threads
5.times do
  Thread.new do
    loop do
      mutex.synchronize do
        while tasks.empty?
          condition_variable.wait(mutex)
        end

        task = tasks.pop
        task.process
        puts 'Consumed task'
      end
    end
  end
end

sleep(10)
