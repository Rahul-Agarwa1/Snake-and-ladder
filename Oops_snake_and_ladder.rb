class SnakesAndLaddersGame
  def initialize(players)
    puts "Welcome to snake and ladder game"
    puts "Game start with player 1"

    @players = players
    @board_size = 36
    @snake = { 34 => 12, 31=>14 }  #hardcoded snake
    @ladder = { 5=> 15, 25=>35 }   #hardcoded ladder
  end
  
  def play
     players_starting_positions = @players.map{0}
     starting_player = 1  #fixed starting player
     winner = move(players_starting_positions, starting_player)
     puts "#{@players[winner]} won!"
  end
  
  private

  def check_if_snake_or_ladder_and_get_the_final_postion(position,player)
  
    came_with_position = position
    while (@snake.keys.include?(position) or @ladder.keys.include?(position))
      #before each move check for win
      if @snake.keys.include?(position)
        position = @snake[position]
        puts "Oh! you got snaked"
      elsif @ladder.keys.include?(position)
        position = @ladder[position]
        #check for win
        puts "Great! you got a ladder"
        if win?(position) == 1
          return "over"
        end
      end
      if came_with_position == position
        puts "a loop is caught here and thus the game is over"
      end
    end

    return 0 if came_with_position == position
    return position

  end

  def win?(position)
    if position == @board_size
      return 1
    end
    return 0
  end

  def dice_roll 
    rand(1..6)
  end
  
  def move(players, player_turn)
    puts "press b to begin the game player -> #{player_turn} "

    input = gets.chomp()

    if input == 'b'
      dice_number_generated = dice_roll
      puts "Number generated after rolling dice is #{dice_number_generated}"
      #for previous cell
      previous_cell = players[player_turn]
      if players[player_turn] + dice_number_generated <= @board_size
        players[player_turn] += dice_number_generated
      end
      #check won condition
      if win?(players[player_turn]) == 1
        # puts " Game over \n Player #{player_turn} won the game  "
        return player_turn
      end
      pos = check_if_snake_or_ladder_and_get_the_final_postion(players[player_turn],player_turn)
      if pos == "over"
        return player_turn
      end
      players[player_turn] = pos == 0 ? players[player_turn] : pos
      #for current cell
      current_cell = players[player_turn]
      next_player = player_turn ^ 1
      puts " for player #{player_turn} previous cell was #{previous_cell}   and current cell is #{current_cell} "
      move(players, next_player)  #instead of using while
    end
  end
  
  
end

Obj = SnakesAndLaddersGame.new([0,1])
Obj.play

