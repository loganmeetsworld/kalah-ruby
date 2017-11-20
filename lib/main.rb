INTRO_SCRIPT = """
Welcome to Kalah. Please select a puddle on the board 1-5.
"""

class Board
  attr_accessor :board, :presenter_board

  def initialize
    @board = [4, 4, 4, 4, 4, 0, 4, 4, 4, 4, 4, 0]
  end
  
  def print_board
    puts "them: [#{@board[11]}] #{@board[6..10].reverse.to_s}"
    puts "you:      #{@board[0..4].to_s} [#{@board[5]}]"
  end

  def move_pieces_right(place)
    pebbles = @board[place - 1]
    @board[place - 1] = 0
    pebbles.times do |x|
      @board[place] += 1
      place += 1
    end
  end

  def move_pieces_left
    place = rand(6..10)
    puts place
    pebbles = @board[place]
    @board[place] = 0
    pebbles.times do |x|
      @board[place + 1] += 1
      place += 1
    end

  end
end

puts INTRO_SCRIPT
b = Board.new
loop do
  place = gets.chomp
  b.move_pieces_right(place.to_i)
  puts b.print_board
  b.move_pieces_left
  puts b.print_board
end
