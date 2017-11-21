INTRO_SCRIPT = """
Welcome to Kalah. Please select a puddle on the board 1-6.
"""

class Game
  attr_accessor :board, :presenter_board

  def initialize
    @board = [4, 4, 4, 4, 4, 4, 0, 4, 4, 4, 4, 4, 4, 0]
  end
  
  def print_board
    # puts @board.to_s
    puts "them: [#{@board[13]}] #{@board[7..12].reverse.to_s}"
    puts "you:      #{@board[0..5].to_s} [#{@board[6]}]"
  end

  def move_pieces(place, player)
    pebbles = @board[place]
    @board[place] = 0
    place = place == 13 ? 0 : place + 1
    while pebbles > 0
      if player == '2' && place == 6 then place = place == 13 ? 0 : place + 1; next end
      if player == '1' && place == 13 then place = place == 13 ? 0 : place + 1; next end
      pebbles -= 1
      @board[place] += 1
      place = place == 13 ? 0 : place + 1
    end
  end
end

puts INTRO_SCRIPT
g = Game.new
puts "starting board: #{g.print_board}"
loop do
  place = gets.chomp
  g.move_pieces(place.to_i - 1, "1")
  puts g.print_board
  other_place = rand(7..12)
  puts other_place - 6
  g.move_pieces(other_place, "2")
  puts g.print_board
end
