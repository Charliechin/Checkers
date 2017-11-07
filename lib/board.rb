class Board
  attr_accessor :board
  def initialize(quarter_number)
    # quarter_number: a Board is made out of 4 quarters.
    # depending of the quarter we apply different methods
    @quarter_number = quarter_number
    #at the moment, I'll just launch the board method here

    @board = Array.new(4) { Array.new(4) }
    initialize_new_board
    initial_state('r')
  end

  def print_current_state

    #YOU MAY HAVE TO CHANGE THIS, AS YOU ARE ITERATING SOBRE UN CUARTO DEL TABLERO
    puts "    0   1   2   3"
    puts "   --------------- "
    @board.each_with_index do |row,i|
      print i
      print ": "
      row.each_with_index do |column,j|
        if @board[i][j].is_empty?
          print "   ".colorize(:background => column.bg_color)
        else
          print " \u{1F534} ".colorize(:background => column.bg_color)
        end
        print " "
      end
      puts ""
      puts ""
    end
    nil
  end

  def select_piece(row,column)
    if @board[row][column].is_empty?
      puts "not a piece"
      false
    else
      puts "Piece[#{row}][#{column}] chosen"
      true
    end
  end

  def move_piece(from={},to={})
    #each argument must be a hash with values :row, :column
    # xx.move_piece({row:0,column:0},{row:2,column:3})

    empty_space = @board[ to[:row] ][ to[:column] ].is_empty?
    piece = self.select_piece(from[:row], from[:column])
    if piece && empty_space && is_valid_move?(from,to)
      from         = @board[ from[:row] ][ from[:column] ]
      to           = @board[   to[:row] ][   to[:column] ]
      temp_content = from.content
      from.content = to.content
      to.content   = temp_content
      self.print_current_state
    else
      puts "nah"
    end
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
  def is_valid_move?(from, to)
   # TODO: check if piece is king 
    if to[:column] > from[:column] && to[:row] != from[:row]
      true
    else
      false
    end
  end
  def initial_state(color_chosen)
    (0..3).each do |row|
      (0..2).each do |cell|
        if cell.even? && row.even? || cell.odd? && row.odd?
          @board[row][cell].content = Piece.new(color_chosen)
        end
      end
    end
    @board
  end
  def generate_quarter(quarter_number)

  end

end
