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
    initial_state
  end

  def print_current_state

    puts "    0    1    2    3    4    5    6    7"
    puts "   ---------------------------------------"
    @board.each_with_index do |row,i|
      print i
      print ": "
      row.each_with_index do |column,j|
        if @board[i][j].is_empty?
          print "    ".colorize(:background => column.bg_color)
        else
          piece = @board[i][j].content.to_s
          print " #{piece}  ".colorize(:background => column.bg_color)
        end
        print " "
      end
      puts ""
      puts ""
    end
    nil
  end

#  def jump_down_right(piece_row, piece_col)
#    down = {row: piece_row + 1,column: piece_col + 1}
#    to_coords = {row: down[:row], column: down[:column]}
#    #delete_piece(piece_coords)
#    movement(piece_coords,to_coords)
#
#  end

  def move_piece(piece_row,piece_col)
    piece = select_piece(piece_row,piece_col)
    piece.nil? ? (return nil) : piece
    #check if where you want to move is blocked (can_move_up_right)
    case piece.color
    when :red
      #CHECK IF THIS IS KING OR NOT
      #from left to right of the board
      can_move_down_right =  can_move_down_right(piece_row,piece_col)
      can_move_up_right   =  can_move_up_right(piece_row,piece_col)
      if can_move_up_right && !can_move_down_right
        move_up_right(piece_row,piece_col)

      elsif can_move_down_right && !can_move_up_right
        move_down_right(piece_row,piece_col)

      elsif !can_move_down_right && !can_move_up_right
      else
        prompt = "> "
        puts "Up or down? --- (u/d) --- "
        print prompt
        while user_input = gets.chomp
          if user_input == "u"
            move_up_right(piece_row,piece_col)
            break
          elsif user_input == "d"
            move_down_right(piece_row,piece_col)
            break
          else
            puts "Nope, Try with 'u' or 'd'"
            puts ""
            print "> "
          end
        end
      end

      print "\u{2714} ".colorize(:light_green)
      print "Moving piece".colorize(:green)
      print "[#{piece_row}][#{piece_col}]".colorize(:light_red)
      puts " "
      self.print_current_state

    when :black
      #CHECK IF THIS IS KING OR NOT
      #from left to right of the board
      can_move_down_left =  can_move_down_left(piece_row,piece_col)
      can_move_up_left   =  can_move_up_left(piece_row,piece_col)
      if can_move_up_left && !can_move_down_left
        move_up_left(piece_row,piece_col)

      elsif can_move_down_left && !can_move_up_left
        move_down_left(piece_row,piece_col)

      elsif !can_move_down_left && !can_move_up_left
      else
        prompt = "> "
        puts "Up or down? --- (u/d) --- "
        print prompt
        while user_input = gets.chomp
          if user_input == "u"
            move_up_left(piece_row,piece_col)
            break
          elsif user_input == "d"
            move_down_left(piece_row,piece_col)
            break
          else
            puts "Nope, Try with 'up' or 'down'"
            puts ""
            print "> "
          end
        end
      end
      print "\u{2714} ".colorize(:light_green)
      print "Moving piece".colorize(:green)
      print "[#{piece_row}][#{piece_col}]".colorize(:light_red)
      puts " "
      self.print_current_state
    else
      print "\u{2716} ".colorize(:light_red)
      puts "Invalid move!"
      self.print_current_state
      return nil
    end
  end
  #red, no king
  def move_down_right(pos_row,pos_col)
    down = {row: pos_row + 1,column: pos_col + 1}
    piece_coords = {row: pos_row, column: pos_col}
    to_coords = {row: down[:row], column: down[:column]}
    movement(piece_coords,to_coords)
  end
  def move_up_right(pos_row,pos_col)
    up   = {row: pos_row - 1,column: pos_col + 1}
    piece_coords = {row: pos_row, column: pos_col}
    to_coords = {row: up[:row], column: up[:column]}
    movement(piece_coords,to_coords)
  end
  #black, no king

  def move_down_left(pos_row,pos_col)
    down = {row: pos_row + 1,column: pos_col - 1}
    piece_coords = {row: pos_row, column: pos_col}
    to_coords = {row: down[:row], column: down[:column]}
    movement(piece_coords,to_coords)
  end

  def move_up_left(pos_row,pos_col)
    up   = {row: pos_row - 1,column: pos_col - 1}
    piece_coords = {row: pos_row, column: pos_col}
    to_coords = {row: up[:row], column: up[:column]}
    movement(piece_coords,to_coords)
  end
  #!black, no king




  private
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

  def delete_piece(piece_coords={})
    #each argument must be a hash with values :row, :column
    @board[ piece_coords[:row] ][ piece_coords[:column]  ].content = "x"
  end


  def can_move_down_right(pos_row,pos_col)
    piece_coords = {row: pos_row, column: pos_col}
    down = {row: piece_coords[:row] + 1,column: piece_coords[:column] + 1}
    to = {row: piece_coords[:row] + 2,column: piece_coords[:column] + 2}
    #if the piece is in the bottom row and tries to move further down
    if down[:row] > @total_rows-1
      print "\u{2716} ".colorize(:light_red)
      puts "Movement out of bounds".colorize(:red)
      return false

    elsif @board[down[:row]][down[:column]].is_empty?
      #to_coords = {row: down[:row], column: down[:column]}
      return true
    else
      print "\u{2716} ".colorize(:light_red)
      puts "down square is not free".colorize(:red)
      piece_from_color         = @board[piece_coords[:row]][piece_coords[:column]].content.color
      piece_to_color           = @board[down[:row]][down[:column]].content.color
      space_to_move_after_jump = @board[down[:row]+1][down[:column]+1]
      if piece_from_color != piece_to_color && space_to_move_after_jump.is_empty?
        delete_piece(down)
        movement(piece_coords, to)
      end
      return false
    end
  end

  def can_move_down_left(pos_row,pos_col)
    # private
    # return true if can move one row down and one row to the left
    # return false if cannot move to that possition

    piece_coords = {row: pos_row, column: pos_col}
    down = {row: piece_coords[:row] + 1,column: piece_coords[:column] - 1}
    if piece_coords[:row] + 2 > @total_rows
      binding.pry
    end
    to = {row: piece_coords[:row] + 2,column: piece_coords[:column] - 2}

    #if the piece is in the bottom row and tries to move further down
    if down[:row] > @total_rows-1
      print "\u{2716} ".colorize(:light_red)
      puts "Movement out of bounds".colorize(:red)
      return false

    elsif @board[down[:row]][down[:column]].is_empty?
      to_coords = {row: down[:row], column: down[:column]}
      return true
    else
      print "\u{2716} ".colorize(:light_red)
      puts "down square is not free".colorize(:red)
      binding.pry
      piece_from_color         = @board[piece_coords[:row]][piece_coords[:column]].content.color
      piece_to_color           = @board[down[:row]][down[:column]].content.color
      begin
        space_to_move_after_jump = @board[to[:row]][to[:column]]
      rescue
        space_to_move_after_jump = nil
      end
      if piece_from_color != piece_to_color && space_to_move_after_jump.is_empty?
        delete_piece(down)
        movement(piece_coords, to)
        print "\u{2716} ".colorize(:light_red)
        puts "Movement out of bounds".colorize(:red)
        return false
      end
      return false
    end
  end

  def can_move_up_right(pos_row,pos_col)
    # private
    # return true if can move one row up and one row to the right
    # return false if cannot move to that possition

    piece_coords = {row: pos_row, column: pos_col}
    up   = {row: piece_coords[:row] - 1,column: piece_coords[:column] + 1}
    to   = {row: piece_coords[:row] - 2,column: piece_coords[:column] + 2}

    #if the piece is in the top row and tries to move further up 
    if to[:row] < 0
      print "\u{2716} ".colorize(:light_red)
      puts "Movement out of bounds".colorize(:red)
      return false
    elsif to[:row] > @total_rows
      binding.pry
    elsif @board[up[:row]][up[:column]].is_empty?
      to_coords = {row: up[:row], column: up[:column]}
      return true
    else
      piece_from_color         = @board[piece_coords[:row]][piece_coords[:column]].content.color
      piece_to_color           = @board[up[:row]][up[:column]].content.color
      space_to_move_after_jump = @board[to[:row]][to[:column]]
      if piece_from_color != piece_to_color && space_to_move_after_jump.is_empty?
        delete_piece(up)
        movement(piece_coords, to)
      end

      return false
    end
  end


  def can_move_up_left(pos_row,pos_col)
    piece_coords = {row: pos_row, column: pos_col}
    up   = {row: piece_coords[:row] - 1,column: piece_coords[:column] - 1}
    to   = {row: piece_coords[:row] - 2,column: piece_coords[:column] - 2}

    #if the piece is in the top row and tries to move further up
    if up[:row] < 0
      print "\u{2716} ".colorize(:light_red)
      puts "Movement out of bounds".colorize(:red)
      #ask the user to move again
      return false

    elsif @board[up[:row]][up[:column]].is_empty?
      to_coords = {row: up[:row], column: up[:column]}
      return true
    else
      piece_from_color         = @board[piece_coords[:row]][piece_coords[:column]].content.color
      piece_to_color           = @board[up[:row]][up[:column]].content.color
      space_to_move_after_jump = @board[to[:row]][to[:column]]

      if piece_from_color != piece_to_color && space_to_move_after_jump.is_empty?
        delete_piece(up)
        movement(piece_coords, to)
      end
      #print "\u{2716} ".colorize(:light_red)
      #puts "up square is not free".colorize(:red)
      return false
    end
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

  def initial_state
    (0..@total_rows-1).each do |row|
      (0..2).each do |cell|
        if cell.even? && row.even? || cell.odd? && row.odd?
          @board[row][cell].content = Piece.new(:red)
        end
      end
    end
    (0..7).each do |row|
      (5..7).each do |cell|
        if cell.even? && row.even? || cell.odd? && row.odd?
          @board[row][cell].content = Piece.new(:black)
        end
      end
    end
    @board
  end

end
