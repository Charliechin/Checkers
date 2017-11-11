require 'colorize'
require 'pry'

require './helpers/helpers'

require './lib/board'
require './lib/square'
require './lib/piece'

prompt = "> "
puts "        Choose an option!"
puts "---------------------------------"
puts " 1. Player vs AI"
puts " 2. Player vs Player"
puts " 3. AI vs AI"
puts "---------------------------------"
print prompt

while user_input = gets.chomp #loops while getting user input
  case user_input
  when "1"
    board_obj = Board.new(1) 
    board_obj.print_current_state
    binding.pry
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

