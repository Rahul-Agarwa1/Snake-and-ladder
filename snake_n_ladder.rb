# requirements 
#  -- 2 players -- 0 players, 1 players
#  -- random function to roll dice => rand(1..10) => both 1 and 10 inclusive
#  -- if snake  -- a pair where first value is source(maximum)
#     and second value is distination (minimum)
#  -- if ladder -- a pair where first value is source(minimum)
#     and second value is distination (maximum)
#  -- if win then stop the game and return the winner
#  -- board size (10 * 10)

require('pry')




def win?(position)
  if position == 100
    return 1
  end
  return 0
end


def check_if_snake_or_ladder_and_get_the_final_postion(position,player)
  
  snake = { 34 => 12, 31=>14 }
  ladder ={ 5=> 15, 25=>35 } 
  came_with_position = position
  # binding.pry
  while (snake.keys.include?(position) or ladder.keys.include?(position))
    #before each move check for win
    if snake.keys.include?(position)
      position = snake[position]
      puts "Oh! you got snaked"
    elsif ladder.keys.include?(position)
      position = ladder[position]
      #check for win
      puts "Great! you get a ladder"
      if win?(position) == 1
        puts " Game over \n Player #{player} won the game  "
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


step = 0 #can be positive negative or zero  => negative in case of snake 
        #and positive in case of ladder and zero in case of nothing 
player0 = 0
player0_current = 0
player1 = 1
player1_current = 0

remove_this = 100

puts "Welcome to snake and ladder game"

current_player = 0

# (0,0) cell currently

puts "Game start with player zero"

while(remove_this)  #put if won condition
  
  puts "press b to begin the game player -> #{current_player} "

  input = gets.chomp()

  if input == 'b'

    dice_roll = rand(1..6)
    puts "Number generated after rolling dice is #{dice_roll}"

    
    #opening condition ==> get open with 0 or 6 -> 
    #i.e eligible to make further move
  
  
    if(current_player == 0)
      #for previous cell
      previous_cell = player0_current
      if player0_current + dice_roll <= 100
        player0_current += dice_roll
      end
      #check for win 
      if win?(player0_current) == 1
        puts " Game over \n Player 0 won the game  "
        return
      end
      pos = check_if_snake_or_ladder_and_get_the_final_postion(player0_current,current_player)
      if pos == "over"
        return
      end
      player0_current = pos == 0 ? player0_current : pos
      #for current cell
      current_cell = player0_current
    else
      #for previous cell
      previous_cell = player1_current
      if player1_current + dice_roll <= 100
        player1_current += dice_roll
      end
      #check for win
      if win?(player1_current) == 1
        puts " Game over \n Player 1 won the game  "
        return
      end
      pos = check_if_snake_or_ladder_and_get_the_final_postion(player1_current,current_player)
      if pos == "over"
        return
      end
      player1_current = pos == 0 ? player1_current : pos
      #for current cell
      current_cell = player1_current
    end
     
    puts " for player #{current_player} previous cell was #{previous_cell}   and current cell is #{current_cell} "

    current_player ^= 1
  end



  remove_this -= 1
end







 


