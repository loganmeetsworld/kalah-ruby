INTRO_SCRIPT = """
Welcome to Kalah. Please select a puddle on the board 1-6 using the numbers on your keyboard.
"""

class Game
  attr_accessor :board, :presenter_board

  def initialize
    @board = [4, 4, 4, 4, 4, 4, 0, 4, 4, 4, 4, 4, 4, 0]
  end
  
  def print_board
    puts "them: [#{@board[13]}] #{@board[7..12].reverse.to_s}"
    puts "you:      #{@board[0..5].to_s} [#{@board[6]}]"
  end

  def game_over?
    @board.slice(0, 6).inject(&:+) == 0 || @board.slice(7, 14).inject(&:+) == 0
  end

  def move_pieces(player)
    place = player == '1' ? gets.chomp.to_i - 1 : rand(7..12)
    pebbles = @board[place]
    if pebbles == 0 || !place.is_a?(Numeric)
      puts "try again"
      move_pieces(player)
    end
    @board[place] = 0
    place += 1
    place = 0 if place == 13
    while pebbles > 0
      if player == '2' && place == 6 then place = place == 13 ? 0 : place + 1; next end
      if player == '1' && place == 13 then place = place == 13 ? 0 : place + 1; next end
      pebbles -= 1
      @board[place] += 1
      place = place == 13 ? 0 : place + 1
    end
    puts "place: #{place}, player: #{player}"
    if player == '1' && place == 7 || player == '2' && place == 13
      print_board
      puts "#{player} gets to go again!"
      move_pieces(player)
    end
  end
end

puts INTRO_SCRIPT
g = Game.new
puts "starting board: #{g.print_board}"
loop do
  g.move_pieces("1")
  puts g.print_board
  g.move_pieces("2")
  puts g.print_board
  if g.game_over?
    break
  end
end
