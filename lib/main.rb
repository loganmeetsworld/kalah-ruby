INTRO_SCRIPT = """
Welcome to Kalah. Please select a puddle on the board 1-6 using the numbers on your keyboard.
"""

class Player
  attr_accessor :type
  def initialize(type)
    @type = type
  end
  
  def human?
    @type == 'human'
  end

  def robot?
    @type == 'robot'
  end
end

class Game
  attr_accessor :board, :presenter_board

  def initialize(p1, p2)
    @board = [4, 4, 4, 4, 4, 4, 0, 4, 4, 4, 4, 4, 4, 0]
    @p1 = p1
    @p2 = p2
  end
  
  def print_board
    puts "them: [#{@board[13]}] #{@board[7..12].reverse.to_s}"
    puts "you:      #{@board[0..5].to_s} [#{@board[6]}]"
  end

  def game_over?
    @board.slice(0, 6).inject(&:+) == 0 || @board.slice(7, 14).inject(&:+) == 0
  end

  def empty_pit?
  end

  def check_for_empty_pit
  end

  def who_won?
    if @board[7] == @board[-1]
      puts "TIE!"
    elsif @board[7] > @board[-1]
      puts "YOU WON!"
    else
      puts "YOU LOST!"
    end
  end

  def move_pieces(player)
    place = player.human? ? gets.chomp.to_i - 1 : rand(7..12)
    pebbles = @board[place]
    if pebbles == 0 || !place.is_a?(Numeric)
      puts "try again"
      move_pieces(player)
    end
    @board[place] = 0
    place += 1
    place = 0 if place == 13
    while pebbles > 0
      if player.robot? && place == 6 then place = place == 13 ? 0 : place + 1; next end
      if player.human? && place == 13 then place = place == 13 ? 0 : place + 1; next end
      pebbles -= 1
      @board[place] += 1
      place = place == 13 ? 0 : place + 1
    end
    puts "place: #{place}, player: #{player}"
    if player.human? && place == 7 || player.robot? && place == 13
      print_board
      puts "#{player} gets to go again!"
      move_pieces(player)
    end
  end
end

puts INTRO_SCRIPT
human_player = Player.new('human')
robot_player = Player.new('robot')
g = Game.new(human_player, robot_player)
puts "starting board: #{g.print_board}"
loop do
  if g.game_over?
    g.who_won?
    break
  end
  g.move_pieces(human_player)
  puts g.print_board
  if g.game_over?
    g.who_won?
    break
  end
  g.move_pieces(robot_player)
  puts g.print_board
end
