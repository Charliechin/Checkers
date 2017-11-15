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

# while user_input = gets.chomp #loops while getting user input
#   case user_input
#   when "1"
    b = Board.new
    b.render
    binding.pry
  #   break
  # when "2"
  #   break
  # when "3"
  #   break
  # when ""
  #   puts "good bye! :("
  #   break
  # end
# end

