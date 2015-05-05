require 'byebug'

def print_money(num)
  puts "$" * num
end

5.times do |i|
  5.times do |j|
    5.times do |k|
      print_money(i*j*k)
    end
  end
end

