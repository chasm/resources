require_relative './bingo.rb'

def assert_true(test)
  raise "should return true" unless test
  puts "passed"
end

def assert_equal(actual, expected)
  raise "expected #{expected} but got #{actual}" unless expected == actual
  puts "passed"
end

def assert_false(test)
  raise "should return false" if test
  puts "passed"
end

def assert_presence(item, collection)
  raise "#{item} not present in collection: #{collection}" unless collection.include?(item)
  puts "passed"
end

def assert_within_range(item, low, high)
  raise "got #{item}, but should be between #{low} and #{high}" unless item.between?(low,high)
  puts "passed"
end

sample_board = [[47, 44, 71, 8, 88],
                [22, 69, 75, 65, 73],
                [83, 85, 97, 89, 57],
                [25, 31, 96, 68, 51],
                [75, 70, 54, 80, 83]]

# Bingo#initialize(board)
  # sets 'board' attribute equal to input board
  # initializes 'letters' attribute equal to an array of letters B, I, N, G, and O
  # initializes 'finished' attribute to false

# Bingo#new_ticket
  # returns a hash with a 'letter' B,I,N,G, or O, and a random number 'number'

# Bingo#column(letter)
  # given a letter, returns corresponding column

# Bingo#mark!(ticket)
  # when given a ticket with a value not existing on the board, nothing happens
  # when given a ticket with a value existing on the board, replaces value with "X"

# Bingo#check_vertical!
  # if vertical win state, sets 'finished' to true

# Bingo#check_horizontal!
  # if horizontal win state, sets 'finished' to true

# Bingo#check_diagonal!
  # if diagonal win state, sets 'finished' to true

# Bingo#check_**!
  # if no win state, check_vertical/horizontal/diagonal do not update finished to true