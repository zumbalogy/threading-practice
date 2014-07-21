require 'thread'

class RainbowThread


  def initialize
    @input = 0
    @old_input = 0
    @diff = 0
    @arrow_counter = 0
    @life = true

    @t1 = Thread.new do
      while @life
        cursor = '|'
        if @diff > 0
          @diff -= 1
          cursor = '>'
        elsif @diff < 0
          @diff += 1
          cursor = '<'
        end
        space_count = (@input * 8) + (8 - @diff)
        puts
        print ' ' * space_count
        print "\033[0;3#{(0..9).to_a.sample}m#{cursor}\033[0m"
        sleep [0.05, 0.06].sample
        @arrow_counter += 1
      end
    end

    @t2 = Thread.new do
      while @life
        @old_input = @input
        @input = (0..9).to_a.sample
        @diff = (@input - @old_input) * 8
        sleep [3,3.1].sample
        self.kill unless @life
      end
    end
  end

  def stop
    @life = false
    @t1.kill
    @t2.kill
  end

end

RainbowThread.new
RainbowThread.new
RainbowThread.new
RainbowThread.new
RainbowThread.new
RainbowThread.new
RainbowThread.new
RainbowThread.new
RainbowThread.new
RainbowThread.new
sleep





