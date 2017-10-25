require 'colorize'
require 'pry'

class Square
  #@content in the future will be a constant. Only these values are allowed:
  # "x" => empty space
  # "r" => red piece

  def initialize(pos_x,pos_y,content = nil)
    # Position x, position y and content
    # By default is "x"
    @pos_col = pos_x
    @pos_row = pos_y
    # improve this validation
    if content.nil?
      @content = "x"
    else
      @content = content
    end
  end

  def get_position
    return [@pos_col,@pos_row]
  end

  def get_content
    @content
  end

  def get_bg_color
    #sholud be private?


    if @pos_col.even? && @pos_row.even? || @pos_col.odd? && @pos_row.odd?
      #colorize color library
      # see String.color_samples on irb for examples

      @color = :light_black
      puts "black".colorize(:background => @color)
    else
      #try light_red
      @color = :light_white
      puts "white".colorize(:light_blue).colorize(:background => @color)
    end
  end

  def update_content(new_content)
    #TODO VALIDATIONS
    # MAKE IT PRIVATE!
    # if new_content is not "x", "r","b","B"... then can't update
    set_content(new_content)
  end

  def get_history
  end

  private

  def set_position(new_pos_x,new_pos_y)
    @pos_col = new_pos_x
    @pos_row = new_pos_y
  end

  def set_content(new_content)
    @content = new_content
  end

end

class Board
  def initialize(quarter_number)
    # quarter_number: a Board is made out of 4 quarters. 
    # depending of the quarter we apply different methods
    @quarter_number = quarter_number
    #at the moment, I'll just launch the board method here

    @board = Array.new(4) { Array.new(4) }
    populate_new_board
  end

  def populate_new_board
    #make private
    (0..3).each do |row|
      (0..3).each do |cell|
        @board[row][cell] = Square.new(cell,row)
      end
    end
    @board

  end

  def get_row(row_number)
    @board[row_number]
  end
  def get_board
    @board
  end

  private
  def generate_quarter(quarter_number)


  end

end
