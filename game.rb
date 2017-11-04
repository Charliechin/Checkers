require 'colorize'
require 'pry'

require './helpers/helpers'

require './lib/board'
require './lib/square'
require './lib/piece'

board_obj = Board.new(1)

#board_obj.initial_state("r")

binding.pry
