class Bingo
  attr_accessor :board, :letters, :finished
  def initialize board
    @board = board
    @letters = "BINGO".chars
    @finished = false
  end

  def new_ticket
    {letter: @letters.sample, number:rand(1..100)}
  end

  def column letter
    index = @letters.index(letter)
    @board.map{|row| row[index]}
  end

  def mark! ticket
    @board[row_num(ticket)][col_num(ticket)] = "X" if row_num(ticket)
  end

  def row_num(ticket)
    column(ticket[:letter]).index(ticket[:number])
  end

  def col_num ticket
    @letters.index(ticket[:letter])
  end

  def check_vertical!
    @letters.each{|letter| @finished = true if column(letter).uniq ==["X"]}
  end

  def check_horizontal!
    @board.each{|row| @finished = true if row.uniq == ["X"]}
  end

  def check_diagonal!
    @finished = true if diagonal_down.uniq == ["X"] || diagonal_up.uniq == ["X"]
  end

  def diagonal_down
    output = []
    5.times do |i|
      puts i
      output  << @board[i][i]
    end
    output
  end

  def diagonal_up
    output= []
    5.times {|i| output << @board[i][4-i]}
    output
  end




end
