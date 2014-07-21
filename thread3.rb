require 'thread'

$input = 0
$old_input = 0
$diff = 0

$arrow_counter = 0

t1 = Thread.new do
  while true
    cursor = '|'
    if $diff > 0
      $diff -= 1
      cursor = '\\'
    elsif $diff < 0
      $diff += 1
      cursor = '/'
    end
    space_count = ($input * 8) + (8 - $diff)
    puts
    print ' ' * space_count
    print "\033[0;3#{(0..9).to_a.sample}m#{cursor}\033[0m"
    sleep 0.05
    $arrow_counter += 1
  end
end

t2 = Thread.new do
  while true
    $old_input = $input
    $input = (0..9).to_a.sample
    $diff = ($input - $old_input) * 8
    sleep 3.3
  end
end

$input2 = 0
$old_input2 = 0
$diff2 = 0

$arrow_counter = 0

t1a = Thread.new do
  while true
    cursor = '|'
    if $diff2 > 0
      $diff2 -= 1
      cursor = '\\'
    elsif $diff2 < 0
      $diff2 += 1
      cursor = '/'
    end
    space_count = ($input2 * 8) + (8 - $diff2)
    puts
    print ' ' * space_count
    print "\033[0;3#{(0..9).to_a.sample}m#{cursor}\033[0m"
    sleep 0.05
    $arrow_counter += 1
  end
end

t2a = Thread.new do
  while true
    $old_input2 = $input2
    $input2 = (0..9).to_a.sample
    $diff2 = ($input2 - $old_input2) * 8
    sleep 3.3
  end
end

t1.join
t2.join
t1a.join
t2a.join
#################################################


