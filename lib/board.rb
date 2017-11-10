class Board
  attr_accessor :board
  def initialize(quarter_number)
    # quarter_number: a Board is made out of 4 quarters.
    # depending of the quarter we apply different methods
    @quarter_number = quarter_number
    #at the moment, I'll just launch the board method here
    @total_rows = 8
    @total_columns = 8
    @board = Array.new(@total_rows) { Array.new(@total_columns) }
    initialize_new_board
    initial_state(:red)
  end

  def print_current_state

    #YOU MAY HAVE TO CHANGE THIS, AS YOU ARE ITERATING SOBRE UN CUARTO DEL TABLERO
    puts "    0   1   2   3   4   5   6   7"
    puts "   -------------------------------"
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
    # select a piece given coords
    # returns  Piece object
    # returns nil if not found

    if @board[row][column].is_empty?
      print "\u{2716} ".colorize(:light_red)
      puts "not a piece".colorize(:red)
      return nil
    else
      print "\u{2714} ".colorize(:light_green)
      puts "Piece chosen".colorize(:green)
      piece = @board[row][column].content
      return piece
    end
  end


  def move_piece(piece_row,piece_col)
    piece = select_piece(piece_row,piece_col)
    piece.nil? ? (return nil) : piece
    #check if where you want to move is blocked (can_move_up)
    case piece.is_king?
    when false && piece.color == :red
      #from left to right of the board
      can_move_down(piece_row,piece_col, piece.color)
      #when true
      print "\u{2714} ".colorize(:light_green)
      print "Moving piece".colorize(:green)
      print "[#{piece_row}][#{piece_col}]".colorize(:light_red)
      print " to ".colorize(:green)
      print "square".colorize(:green)
      puts "[x][y]".colorize(:red)
      self.print_current_state

    else
      print "\u{2716} ".colorize(:light_red)
      puts "Invalid move!"
      self.print_current_state
      return nil
    end
  end

  private
  def can_move_up(pos_row,pos_col, piece_color)
    piece_coords = {row: pos_row, column: pos_col}
    up   = {row: piece_coords[:row] - 1,column: piece_coords[:column] + 1}
    #down = {row: piece_coords[:row] + 1,column: piece_coords[:column] + 1}
    case piece_color
    when :red
      #if the piece is in the top row and tries to move further up
      if up[:row] < 0
        print "\u{2716} ".colorize(:light_red)
        puts "Movement out of bounds".colorize(:red)
        self.print_current_state
        return nil

      elsif @board[up[:row]][up[:column]].is_empty?
        to_coords = {row: up[:row], column: up[:column]}
        #MOVE PIECE HERE, EVERYTHING HAS BEEN CHECKED. METHOD THAT JUST MOVES AROUND A PIECE
        puts "make User choose here if he wants to move up"
        #print here the board with options highlighted
        sleep 2
        movement(piece_coords, to_coords)
      else
        print "\u{2716} ".colorize(:light_red)
        puts "square is not free".colorize(:red)
        return nil
      end
    end
  end
 


  def can_move_down(pos_row,pos_col, piece_color)
    piece_coords = {row: pos_row, column: pos_col}
    #up   = {row: piece_coords[:row] - 1,column: piece_coords[:column] + 1}
    down = {row: piece_coords[:row] + 1,column: piece_coords[:column] + 1}
    case piece_color
    when :red
      #if the piece is in the bottom row and tries to move further down
      if down[:row] > @total_rows-1
        print "\u{2716} ".colorize(:light_red)
        puts "Movement out of bounds".colorize(:red)
        self.print_current_state
        return nil

      elsif @board[down[:row]][down[:column]].is_empty?
        to_coords = {row: down[:row], column: down[:column]}
        #MOVE PIECE HERE, EVERYTHING HAS BEEN CHECKED. METHOD THAT JUST MOVES AROUND A PIECE
        puts "make User choose here if he wants to move down"
        #print here the board with options highlighted
        sleep 2
        movement(piece_coords, to_coords)
      else
        print "\u{2716} ".colorize(:light_red)
        puts "square is not free".colorize(:red)
        return nil
      end
    end
  end





  def movement(from={},to={})
    #each argument must be a hash with values :row, :column
    # xx.move_piece({row:0,column:0},{row:2,column:3})
    #binding.pry
    #piece = @board[ from[:row] ][ from[:column] ].content

    from         = @board[ from[:row] ][ from[:column] ]
    to           = @board[   to[:row] ][   to[:column] ]
    temp_content = from.content
    from.content = to.content
    to.content   = temp_content
    #self.print_current_state
  end



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

  def initial_state(color_chosen)
    (0..7).each do |row|
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
