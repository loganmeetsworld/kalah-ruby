class Player
  attr_accessor :player_type
  def initialize(player_type)
    @player_type = player_type
  end
  
  def human?
    @player_type == 'human'
  end

  def ai?
    @player_type == 'ai'
  end
end

class Board
  attr_accessor :board, :presenter_board

  def initialize(p1, p2)
    @puddles = [4, 4, 4, 4, 4, 4, 0, 4, 4, 4, 4, 4, 4, 0]
    @p1 = p1
    @p2 = p2
  end
  
  def print_board
    puts "them: [#{@puddles[13]}] #{@puddles[7..12].reverse.to_s}"
    puts "you:      #{@puddles[0..5].to_s} [#{@puddles[6]}]"
  end

  def game_over?
    @puddles.slice(0, 6).inject(&:+) == 0 || @puddles.slice(7, 14).inject(&:+) == 0
  end

  def empty_pit?(pit)
    @puddles[pit] == 0
  end

  def opposite_pit_full?(pit)
    pit + 6 != 0
  end

  def check_for_empty_pit
  end

  def who_won?
    if @puddles[7] == @puddles[-1]
      puts "TIE!"
    elsif @puddles[7] > @puddles[-1]
      puts "YOU WON!"
    else
      puts "YOU LOST!"
    end
  end

  def exit?
    gets.chomp == 'quit' || gets.chomp == 'quit'
  end

  def move_pieces(player)
    pit = player.human? ? gets.chomp.to_i - 1 : rand(7..12)
    pebbles = @puddles[pit]
    if pebbles == 0 || !pit.is_a?(Numeric)
      if player.human? then puts "Invalid. Try again." end
      move_pieces(player)
    end
    # if empty_pit?(pit) && opposite_pit_full?(pit)
    #   @puddles[6] += (@puddles[pit] + @puddles[pit + 6])
    # else

    @puddles[pit] = 0
    pit += 1
    pit = 0 if pit == 13
    while pebbles > 0
      if player.ai? && pit == 6 then pit = pit == 13 ? 0 : pit + 1; next end
      if player.human? && pit == 13 then pit = pit == 13 ? 0 : pit + 1; next end
      pebbles -= 1
      @puddles[pit] += 1
      pit = pit == 13 ? 0 : pit + 1
    end

    if player.human? && pit == 7 || player.ai? && pit == 13
      print_board
      puts "#{player.player_type} gets to go again!"
      move_pieces(player)
    end
  end
end

class Game
  attr_accessor :board

  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
    @board = Board.new(player_1, player_2)
  end

  def print_instructions
    intro_script = """
    Welcome to Kalah. Please select a puddle on the board 1-6 using the numbers on your keyboard.
    """
    puts intro_script
    puts @board.print_board
  end

  def start_game
    loop do
      if @board.game_over?
        @board.who_won?
        break
      end
      @board.move_pieces(@player_1)
      puts @board.print_board
      if @board.game_over?
        @board.who_won?
        break
      end
      @board.move_pieces(@player_2)
      puts @board.print_board
    end
  end
end

human_player = Player.new('human')
ai_player = Player.new('ai')
game = Game.new(human_player, ai_player)
game.print_instructions
game.start_game
