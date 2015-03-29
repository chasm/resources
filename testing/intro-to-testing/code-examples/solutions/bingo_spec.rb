require_relative './bingo.rb'

def assert_true(test)
  raise "should return true" unless test
  puts "passed!"
end

def assert_equal(actual, expected)
  raise "expected #{expected} but got #{actual}" unless expected == actual
  puts "passed!"
end

def assert_false(test)
  raise "should return false" if test
  puts "passed!"
end

def assert_presence(item, collection)
  raise "#{item} not present in collection: #{collection}" unless collection.include?(item)
  puts "passed!"
end

def assert_within_range(item, low, high)
  raise "got #{item}, but should be between #{low} and #{high}" unless item.between?(low,high)
  puts "passed!"
end

# Bingo#initialize(board)
  sample_board = [[47, 44, 71, 8, 88],
                  [22, 69, 75, 65, 73],
                  [83, 85, 97, 89, 57],
                  [25, 31, 96, 68, 51],
                  [75, 70, 54, 80, 83]]
  bingo = Bingo.new(sample_board)

  # sets 'board' attribute equal to input board
    assert_equal(bingo.board, sample_board)

  # initializes 'letters' attribute equal to an array of letters B, I, N, G, and O
    assert_equal(bingo.letters, ["B","I","N","G","O"])

  # initializes 'finished' attribute to false
    assert_false(bingo.finished)

# Bingo#new_ticket

  # returns a hash with a 'letter' B,I,N,G, or O, and a random number 'number'
    ticket = bingo.new_ticket
    assert_presence(ticket[:letter], bingo.letters)
    assert_within_range(ticket[:number],1,100)

# Bingo#column(letter)

  # given a letter, returns corresponding column
    assert_equal(bingo.column("B"), [47,22,83,25,75])
    assert_equal(bingo.column("N"), [71,75,97,96,54])

# Bingo#mark!(ticket)

  # when given a ticket with a value not existing on the board, nothing happens
    ticket = {letter: "B", number: 24}
    bingo.mark!(ticket)
    assert_equal(bingo.board, sample_board)

  # when given a ticket with a value existing on the board, replaces value with "X"
    ticket = {letter: "B", number: 25}
    bingo.mark!(ticket)
    assert_equal(bingo.board[3][0], "X")

# Bingo#check_vertical!

  # if vertical win state, sets 'finished' to true
    sample_board = [[47, "X", 71,  8, 88],
                    [22, "X", 75, 65, 73],
                    [83, "X", 97, 89, 57],
                    [25, "X", 96, 68, 51],
                    [75, "X", 54, 80, 83]]
    bingo = Bingo.new(sample_board)
    bingo.check_vertical!
    assert_true(bingo.finished)

# Bingo#check_horizontal!

  # if horizontal win state, sets 'finished' to true
    sample_board = [[47, 22, 71, 8, 88],
                    [22, 1, 75, 65, 73],
                    ["X","X","X","X","X"],
                    [25, 34, 96, 68, 51],
                    [75, 98, 54, 80, 83]]
    bingo = Bingo.new(sample_board)
    bingo.check_horizontal!
    assert_true(bingo.finished)

# Bingo#check_diagonal!

  # if diagonal win state, sets 'finished' to true
    sample_board = [["X",22, 71, 8, 88],
                    [22,"X", 75, 65, 73],
                    [83, 67,"X", 89, 57],
                    [25, 34, 96,"X", 51],
                    [75, 98, 54, 80,"X"]]
    bingo = Bingo.new(sample_board)
    bingo.check_diagonal!
    assert_true(bingo.finished)

    sample_board = [[47, 22, 71,  8,"X"],
                    [22,  1, 75,"X", 73],
                    [83, 67,"X", 89, 57],
                    [25,"X", 96, 68, 51],
                    ["X", 98, 54, 80, 83]]
    bingo = Bingo.new(sample_board)
    bingo.check_diagonal!
    assert_true(bingo.finished)

# Bingo#check_**!

  # if no win state, check_vertical/horizontal/diagonal do not update finished to true
    sample_board = [[47, 44, 71, 8, 88],
                    [22, 69, 75, 65, 73],
                    [83, 85, 97, 89, 57],
                    [25, 31, 96, 68, 51],
                    [75, 70, 54, 80, 83]]
    bingo = Bingo.new(sample_board)
    bingo.check_vertical!
    bingo.check_horizontal!
    bingo.check_diagonal!
    assert_false(bingo.finished)