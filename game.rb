require 'colorize'
require 'pry'

require './helpers/helpers'

require './lib/board'
require './lib/square'
require './lib/piece'

prompt = "> "
puts "        Choose an option!"
puts "---------------------------------"
puts " 1. Player vs Player"
puts " 2. Player vs CPU"
puts " 3. CPU vs CPU"
puts "---------------------------------"
print prompt


def initialize
  binding.pry
end
def get_input
  #outputs a hash where user wants to move
  #direction :UR :UL :DR :DL
  puts "Row?"
  row = gets.chomp
  puts "Column?"
  column = gets.chomp
    puts "Direction? (UR, UL, DR, DL)"
  direction = gets.chomp
  result = {row: row.to_i, column: column.to_i, direction: direction.upcase.to_sym}
  return result
end

def player_turn(color,board)
   puts " ------ ------ ------"
   puts "       #{color} turn!"
   puts " ------ ------ ------\n"
   user_input = get_input
   board.move_from(user_input, user_input[:direction])
end

def player_vs_player
  b = Board.new
  playing = true
  while(playing)
    b.render
    player_turn("Red",b)
    player_turn("Blue",b)
  end
end



while user_input = gets.chomp #loops while getting user input
  case user_input
  when "1"

    player_vs_player
    break
  when "2"
    break
  when "3"
    break
  when ""
    puts "good bye! :("
    break
  end
end