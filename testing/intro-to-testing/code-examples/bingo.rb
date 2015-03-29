class Bingo

  attr_accessor :board, :letters, :finished

  def initialize(board)
  end

  def new_ticket
  end

  def column(letter)
  end

  def mark!(ticket)
  end

  def check_vertical!
  end

  def check_horizontal!
  end

  def check_diagonal!
  end

  def print_board
    system('clear')
    @board.each do |row|
      row.each { |number| print number.to_s.ljust(4) }
      puts
    end
  end

end