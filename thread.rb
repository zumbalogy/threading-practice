require 'thread'
require 'pry'

$input = ''

$foo = 'food'
bar = 'clif bar   '

t = Thread.new do
  while true
    print '   ' * [1,2,4,6].sample
    sleep 0.009
    print "\033[0;35m#{$input}\033[0m"
    sleep 0.022
  end
end

t2 = Thread.new do
  while true
    color = (0..4).to_a.sample
    print "\033[0;3#{color}m>\033[0m"
    sleep 0.027
    print "\033[0;3#{color}m<\033[0m"
    sleep 0.01
  end
end

t3 = Thread.new do
  while true
    a = gets.chomp.to_s
    begin
      $input = eval(a)
    rescue
      $input = a
    end
  end
end

puts
puts 'start'

while true
  puts
  print ' ' * [0,0,1,2,3].sample
  sleep 0.03
  print "\033[0;3#{(6..9).to_a.sample}m|\033[0m"
  sleep 0.03
end

t.join
t2.join
t3.join


puts
puts
puts 'end'
puts