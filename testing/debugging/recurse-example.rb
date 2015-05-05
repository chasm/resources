require 'byebug'

def recurse(num)
  num += 1
  print_money(num)
  recurse(num)
end

def print_money(num)
  puts "$" * num
end

recurse(0)