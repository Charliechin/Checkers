class Board
  attr_accessor :board
  def initialize(quarter_number)
    # quarter_number: a Board is made out of 4 quarters.
    # depending of the quarter we apply different methods
    @quarter_number = quarter_number
    #at the moment, I'll just launch the board method here

    @board = Array.new(4) { Array.new(4) }
    initialize_new_board
  end



  # color_chosen ={ "r","b"}
  def initial_state(color_chosen)
    #make private
    (0..3).each do |row|
      (0..2).each do |cell|
        if cell.even? && row.even? || cell.odd? && row.odd?
          @board[row][cell].content = Piece.new(color_chosen)
        end
      end
    end
    @board
  end




  def print_current_state

    #YOU MAY HAVE TO CHANGE THIS, AS YOU ARE ITERATING SOBRE UN CUARTO DEL TABLERO
    @board.each_with_index do |row,i|
      row.each_with_index do |column,j|
        print " "
        if @board[i][j].is_empty?
          print "   ".colorize(:background => column.bg_color)
        else
          print " X "
        end
        print " "
      end
      puts ""
      puts ""
    end
    nil
  end

  private
  def initialize_new_board
    # This method will be called everytime a Board instance is generated
    @board.each_with_index do |row,i|
      row.each_with_index do |column,j|
        if i.even? && j.even? || i.odd? && j.odd?
          @board[i][j] = Square.new(nil,:black)
        else
          @board[i][j] = Square.new(nil,:white)
        end
      end
    end
    @board
  end
  def generate_quarter(quarter_number)

  end

end
