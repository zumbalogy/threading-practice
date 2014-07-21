require 'thread'

$input = 0
$old_input = 0
$diff = 0

$arrow_counter = 0

t1 = Thread.new do
  while true
    if $arrow_counter > 3
      cursor = 'V'
      $arrow_counter = 0
    else
      cursor = '|'
    end
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
    a = gets.chomp.to_s
    b = a.to_i.to_s[0].to_i
    $input = b
    $diff = ($input - $old_input) * 8
  end
end

puts
puts 'start'

t1.join
t2.join

puts
puts
puts 'end'
puts