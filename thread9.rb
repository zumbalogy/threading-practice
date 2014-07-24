require 'thread'

$printer = []

$positions = []

5.times {$positions << Mutex.new}

class RainbowThread

  def initialize
    start = rand(5)
    @input = start
    @old_input = start
    @diff = 0
    @arrow_counter = 0
    @life = 300
    @color = rand(9)

    @t1 = Thread.new do
      while @life > 0
        cursor = '|'
        if @diff > 0
          @diff -= 1
          cursor = '\\'
        elsif @diff < 0
          @diff += 1
          cursor = '/'
        end
        space_count = (@input * 8) + (8 - @diff)
        $printer << [space_count, @color, cursor]
        sleep 0.03
        @arrow_counter += 1
        @life -= 1
      end
      self.stop
    end

    @t2 = Thread.new do
      while @life > 0
        try = $positions.sample {|m| m.locked? == false}
        try = $positions.index(try)
        if $positions[try].try_lock
          @old_input = @input
          @input = try
          @diff = (@input - @old_input) * 8
          sleep 0.99
          $positions[try].unlock
          sleep 0.03
          @life += 300
        end
      end
      self.stop
    end
  end

  def stop
    @t1.kill
    @t2.kill
  end

  def alive?
    @t1.alive? && @t2.alive?
  end

end

thread_array = []

4.times { thread_array << RainbowThread.new }

start_time = Time.now

while true
  printing = []
  $printer.each do |item|
    printing[item.first] = "\033[0;3#{item[1]}m#{item.last}\033[0m"
  end
  printing.map! { |x| x.nil? ? ' ' : x }
  print printing.join
  puts
  $printer = []
  sleep 0.03
  break if (thread_array.count &:alive?) < 4
end

puts
puts
puts "#{Time.now - start_time} is your score"
puts


