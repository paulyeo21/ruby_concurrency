# Implement rate limiting using a naive token bucket filter algorithm.
#
# - Imagine you have a bucket that gets filled with tokens at the rate of 1 token per second. The bucket can hold a maximum of N tokens. Implement a thread-safe class that lets threads get a token when one is available. If no token is available, then the token-requesting threads should block.
#
# - Specs:
# * New tokens are added to the bucket at the rate of 1 token per second.
# * Bucket has a cap of maximum N tokens.
# * If no token is available, block until available.

class RateLimitedTokenBucket
  attr_accessor :timestamp, :possible_tokens

  def initialize(max_tokens)
    @timestamp = Time.now
    @max_tokens = max_tokens
    @possible_tokens = 0
    @monitor = Monitor.new
    @cond = @monitor.new_cond
  end

  def get_token
    @monitor.synchronize do
      current_time = Time.now
      while @possible_tokens == 0
        possible_tokens = calc_possible_tokens(current_time)
        puts possible_tokens
        set_tokens(possible_tokens)
        puts @possible_tokens
      end

      @possible_tokens -= 1
    end
  end

  private

  def calc_possible_tokens(time)
    set_timestamp(time)
    (time - @timestamp).floor
  end

  def set_timestamp(time)
    @timestamp = time
  end

  def set_tokens(tokens)
    if tokens > @max_tokens || @possible_tokens + tokens > @max_tokens
      @possible_tokens = @max_tokens
    else
      @possible_tokens += tokens
    end
  end
end

## Spec #set_tokens

# bucket = RateLimitedTokenBucket.new(10)

# bucket.send(:set_tokens, 1)
# puts bucket.possible_tokens == 1

# bucket.send(:set_tokens, 2)
# puts bucket.possible_tokens == 3

# bucket.send(:set_tokens, 10)
# puts bucket.possible_tokens == 10

# bucket.send(:set_tokens, 10)
# puts bucket.possible_tokens == 10

##

bucket = RateLimitedTokenBucket.new(2)

t1 = Thread.new do
end

t2 = Thread.new do
  bucket.get_token
  puts "Thread 2 has taken a token"
end

t3 = Thread.new do
  bucket.get_token
  puts "Thread 3 has taken a token"
end

[t1, t2, t3].each(&:join)

