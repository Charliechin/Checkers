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
  # color_chosen ={ "r","b"}
  def initial_state(color_chosen)
    #make private
    (0..3).each do |row|
      (0..2).each do |cell|
        if cell.even? && row.even? || cell.odd? && row.odd?
          @board[row][cell] = Piece.new(cell,row,color_chosen)
        else
          # empty
          @board[row][cell] = Square.new(cell,row,"x")
        end
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
