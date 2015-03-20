require_relative './bingo.rb'

bingo = Bingo.new(sample_board)
until bingo.finished
  ticket = bingo.new_ticket
  bingo.mark!(ticket)
  bingo.print_board
  bingo.check_vertical!
  bingo.check_horizontal!
  bingo.check_diagonal!
  sleep(0.01)
end