require 'thread'

$printer = []

class RainbowThread

  def initialize
    @input = 0
    @old_input = 0
    @diff = 0
    @arrow_counter = 0
    @life = (Random.rand * 300) + 30
    @color = (0..9).to_a.sample

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
        sleep 0.04
        @arrow_counter += 1
        @life -= 1
      end
      self.stop
    end

    @t2 = Thread.new do
      while @life > 0
        @old_input = @input
        @input = (0..9).to_a.sample
        @diff = (@input - @old_input) * 8
        sleep [2.5,3].sample
      end
      self.stop
    end
  end

  def stop
    @t1.kill
    @t2.kill
  end

end

5.times do
  RainbowThread.new
end

while true
  if Random.rand > 0.97
    RainbowThread.new
  end
  printing = []
  $printer.each do |item|
    printing[item.first] = "\033[0;3#{item[1]}m#{item.last}\033[0m"
  end
  printing.map! {|x| x.nil? ? ' ' : x}
  print printing.join
  puts
  $printer = []
  sleep 0.03
end




