class Board
  attr_accessor :board, :history, :undoArr, :redoArr
  def initialize
    @total_rows = 6
    @total_columns= 6
    @history = []
    @undoArr = []
    @redoArr = []
    @board = Array.new(@total_rows) { Array.new(@total_columns) }
    initialize_new_board
    initial_state
  end
  def can_move_to?(piece_coords={},direction)
    #piece_coords: Hash with values :row, :column i.e. piece_coords={row:0,column:1}
    #   direction: Symbol with positions to check i.e. ":UR" (up right), ":DR" (down right)
    #returns bool
    # assumes you are passing a valid piece
    directions = {
      #UR: up-right; DR: down-right; UL: up-left; DL: down-left
      :UR =>  {row: piece_coords[:row] - 1,column: piece_coords[:column] + 1},
      :DR =>  {row: piece_coords[:row] + 1,column: piece_coords[:column] + 1},
      :UL =>  {row: piece_coords[:row] - 1,column: piece_coords[:column] - 1},
      :DL =>  {row: piece_coords[:row] + 1,column: piece_coords[:column] - 1},
    }
    case  direction
    when :UR
      #if the piece moves out of bounds, stop
      if directions[:UR][:row] < 0 || directions[:UR][:column] >= @total_rows
        return false
      #if the place is empty, therefore the piece can move, move.
    elsif @board[directions[:UR][:row]][directions[:UR][:column]].is_empty?
      return true
    else
        #THIS else branch means that a piece has been found in the place where you want to move
        #is it able to jump if color is different?
        binding.pry
      end
    when :DR
      #if the piece moves out of bounds, stop
      if directions[:DR][:row] > @total_rows-1 || directions[:DR][:column] >= @total_rows
        return false
      #if the place is empty, therefore the piece can move, move.
    elsif @board[directions[:DR][:row]][directions[:DR][:column]].is_empty?
      return true
    else
        #THIS else branch means that a piece has been found in the place where you want to move
        #is it able to jump if color is different?
        binding.pry
      end
    when :UL
      #if the piece moves out of bounds, stop
      if directions[:UL][:row] < 0 || directions[:UL][:column] < 0
        return false
      #if the place is empty, therefore the piece can move, move.
    elsif @board[directions[:UL][:row]][directions[:UL][:column]].is_empty?
      return true
    else
        #THIS else branch means that a piece has been found in the place where you want to move
        #is it able to jump if color is different?
        binding.pry
      end
    when :DL
      #if the piece moves out of bounds, stop
      if directions[:DL][:row] > @total_rows-1 || directions[:DL][:column] < 0
        return false
      #if the place is empty, therefore the piece can move, move.
    elsif @board[directions[:DL][:row]][directions[:DL][:column]].is_empty?
      return true
    else
        #THIS else branch means that a piece has been found in the place where you want to move
        #is it able to jump if color is different?
        binding.pry
      end
    end
  end

  def print_current_state

    puts "    0    1    2    3    4    5    6   7"
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

  def save_state
    @history << Marshal.load( Marshal.dump(self.board) )
    @undoArr << Marshal.load( Marshal.dump(self.board) )
    puts "movement saved"
  end
  
  def move_piece(piece_row,piece_col)
    binding.pry
    piece = select_piece(piece_row,piece_col)
    piece.nil? ? (return nil) : piece
    piece_coords = {row: piece_row, column: piece_col}
    case piece.color
    when :red
      #CHECK IF THIS IS KING OR NOT
      #from left to right of the board

      if can_move_to?(piece_coords,:UR) && !can_move_to?(piece_coords,:DR)
        move_to(piece_coords,:UR)
      elsif can_move_to?(piece_coords,:DR) && !can_move_to?(piece_coords,:UR)
        move_to(piece_coords,:DR)

      else
        prompt = "> "
        puts "Up or down? --- (u/d) --- "
        print prompt
        while user_input = gets.chomp
          if user_input == "u"
            #check if king
            if piece_col == @total_columns - 1
            end
            move_to(piece_coords,:UR)
            break
          elsif user_input == "d"
            #check if king
            move_to(piece_coords,:DR)
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

      if can_move_to?(piece_coords,:UL) && !can_move_to?(piece_coords,:DL)
        move_to(piece_coords, :UL)

      elsif can_move_to?(piece_coords,:DL) && !can_move_to?(piece_coords,:UL)
        move_to(piece_coords, :DL)

      else
        prompt = "> "
        puts "Up or down? --- (u/d) --- "
        print prompt
        while user_input = gets.chomp
          if user_input == "u"
            move_to(piece_coords,:UL)
            break
          elsif user_input == "d"
            move_to(piece_coords,:DL)
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

  #!black, no king


  def undo_movement
    prev_state = undoArr.pop
    @redoArr << self.board
    self.board = prev_state
    self.print_current_state
    puts "Undo completed... you cheater!"
  end

  def redo_movement
    next_state = redoArr.pop
    @undoArr << self.board
    self.board = next_state
    self.print_current_state
    puts "redo completed... you cheater!"
  end
  def move_to(piece_coords={}, direction)
#piece_coords: Hash with values :row, :column i.e. piece_coords={row:0,column:1}
#   direction: Symbol with positions to move i.e. ":UR" (up right), ":DR" (down right)
#returns void
# assumes you are passing a valid piece

# TODO!!!! !!! !! IMPORTANT!!!
# turns into king the piece passed if reaches the beginning or end of the board

directions = {
  :UR =>  {row: piece_coords[:row] - 1,column: piece_coords[:column] + 1},
  :DR =>  {row: piece_coords[:row] + 1,column: piece_coords[:column] + 1},
  :UL =>  {row: piece_coords[:row] - 1,column: piece_coords[:column] - 1},
  :DL =>  {row: piece_coords[:row] + 1,column: piece_coords[:column] - 1},
}
self.save_state
return movement(piece_coords, directions[direction])
end

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
    (0..@total_rows-1).each do |row|
      # 5...
      (5..@total_rows-1).each do |cell|
        if cell.even? && row.even? || cell.odd? && row.odd?
          @board[row][cell].content = Piece.new(:black)
        end
      end
    end
    @board
  end

end
