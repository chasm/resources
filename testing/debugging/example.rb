require 'pry-byebug'

def recurse(num)
  binding.pry
  puts num
  num += 1
  recurse(num)
end

recurse(0)