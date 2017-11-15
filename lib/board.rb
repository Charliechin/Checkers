class Board
  attr_accessor :board, :history, :undoArr, :redoArr

  def initialize
      @total_rows = 4
      @total_columns= 4
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
      #returns bool unless there's an option to jump
      # assumes you are passing a valid piece
      directions = {
        #UR: up-right; DR: down-right; UL: up-left; DL: down-left
        :UR =>  {row: piece_coords[:row] - 1,column: piece_coords[:column] + 1},
        :DR =>  {row: piece_coords[:row] + 1,column: piece_coords[:column] + 1},
        :UL =>  {row: piece_coords[:row] - 1,column: piece_coords[:column] - 1},
        :DL =>  {row: piece_coords[:row] + 1,column: piece_coords[:column] - 1},
      }

      
piece = select_piece(piece_coords[:row],piece_coords[:column])
      if piece.is_king?
      else
       if piece.color == :red 
        puts "SOYR ROKJO NO KING"
        case direction
      when :UR
        #if the piece moves out of bounds, stop
        if directions[:UR][:row] < 0 || directions[:UR][:column] >= @total_rows
          return false
          #if the place is empty, therefore the piece can move, move.
        elsif @board[directions[:UR][:row]][directions[:UR][:column]].is_empty?

          return true
        else
                    return "something found"

        end
      when :DR
        #if the piece moves out of bounds, stop
        if directions[:DR][:row] > @total_rows-1 || directions[:DR][:column] >= @total_rows
          return false
          #if the place is empty, therefore the piece can move, move.
        elsif @board[directions[:DR][:row]][directions[:DR][:column]].is_empty?
          return true
        else
return "something found"
        end
        else
          puts "YOU MUST BE A KING!"
          return false
        end
        binding.pry
       else
        puts "SOY NEGRO NO KING"
        case direction
      when :UL
        #if the piece moves out of bounds, stop
        if directions[:UL][:row] < 0 || directions[:UL][:column] < 0
          return false
          #if the place is empty, therefore the piece can move, move.
        elsif @board[directions[:UL][:row]][directions[:UL][:column]].is_empty?
          return true
        else
          return "something found"

        end
      when :DL
        #if the piece moves out of bounds, stop
        if directions[:DL][:row] > @total_rows-1 || directions[:DL][:column] < 0
          return false
          #if the place is empty, therefore the piece can move, move.
        elsif @board[directions[:DL][:row]][directions[:DL][:column]].is_empty?
          return true
        else
                    return "something found"

        end
        else
          puts "YOU MUST BE A KING!"
          return false
       end
     end
      end


      # case  direction
      # when :UR
      #   #if the piece moves out of bounds, stop
      #   if directions[:UR][:row] < 0 || directions[:UR][:column] >= @total_rows
      #     return false
      #     #if the place is empty, therefore the piece can move, move.
      #   elsif @board[directions[:UR][:row]][directions[:UR][:column]].is_empty?

      #     return true
      #   else
      #               return "something found"

      #   end
      # when :DR
      #   #if the piece moves out of bounds, stop
      #   if directions[:DR][:row] > @total_rows-1 || directions[:DR][:column] >= @total_rows
      #     return false
      #     #if the place is empty, therefore the piece can move, move.
      #   elsif @board[directions[:DR][:row]][directions[:DR][:column]].is_empty?
      #     return true
      #   else
      #       #   binding.pry
      #       #   #THIS else branch means that a piece has been found in the place where you want to move
      #       #   #is it able to jump if color is different?
      #       #   piece = select_piece(piece_coords[:row],piece_coords[:column])
      #       #   enemy_piece = select_piece(directions[direction][:row],directions[direction][:column])
      #       #   enemy_piece_coords = {row: directions[direction][:row], column: directions[direction][:column]}
      #       #   after_jump_coords = {row: directions[direction][:row] +1 , column: directions[direction][:column] + 1}
      #       #   begin
      #       #     after_jump_is_empty = self.board[after_jump_coords[:row]][after_jump_coords[:column]].is_empty?
      #       #   rescue
      #       #     puts "OUT OF BOUNDS!"
      #       #     return
      #       #   end
      #       #   #if something weird happen, try after_jump_coords[:row] < @total_rows-1
      #       #   if after_jump_coords[:row] < @total_rows && after_jump_coords[:column] < @total_columns && after_jump_is_empty
      #       #     #it is safe to jump here
      #       #     #after_jump, try deleting the enemy piece
      #       #     jump_to(piece_coords,:DR)
      #       #     delete_piece(enemy_piece_coords)
      #       #   else
      #       #     puts "YOU CANNOT MOVE!"
      #       #     nil
      #       #   end
      #   end
      # when :UL
      #   #if the piece moves out of bounds, stop
      #   if directions[:UL][:row] < 0 || directions[:UL][:column] < 0
      #     return false
      #     #if the place is empty, therefore the piece can move, move.
      #   elsif @board[directions[:UL][:row]][directions[:UL][:column]].is_empty?
      #     return true
      #   else
      #     return "something found"

      #   end
      # when :DL
      #   #if the piece moves out of bounds, stop
      #   if directions[:DL][:row] > @total_rows-1 || directions[:DL][:column] < 0
      #     return false
      #     #if the place is empty, therefore the piece can move, move.
      #   elsif @board[directions[:DL][:row]][directions[:DL][:column]].is_empty?
      #     return true
      #   else
      #               return "something found"

      #   end
      # end
  end

  def render

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




  def undo
      prev_state = undoArr.pop
      @redoArr << self.board
      self.board = prev_state
      self.render
      puts "Undo completed... you cheater!"
  end

  def redo
      next_state = redoArr.pop
      @undoArr << self.board
      self.board = next_state
      self.render
      puts "redo completed... you cheater!"
  end
# move stuff
  def move_from(piece_coords={}, direction)
      #piece_coords: Hash with values :row, :column i.e. piece_coords={row:0,column:1}
      #   direction: Symbol with positions to move i.e. ":UR" (up right), ":DR" (down right)
      piece = select_piece(piece_coords[:row],piece_coords[:column])
      piece.nil? ? return : nil

      directions = {
        :UR =>  {row: piece_coords[:row] - 1,column: piece_coords[:column] + 1},
        :DR =>  {row: piece_coords[:row] + 1,column: piece_coords[:column] + 1},
        :UL =>  {row: piece_coords[:row] - 1,column: piece_coords[:column] - 1},
        :DL =>  {row: piece_coords[:row] + 1,column: piece_coords[:column] - 1},
      }
      self.save_state
      piece_from = @board[ piece_coords[:row] ][ piece_coords[:column] ]
      piece_to   =  @board[directions[direction][:row]][directions[direction][:column]]
      piece_to.content = Marshal.load( Marshal.dump(piece_from.content) )
      piece_from.content = "x"
      
      if piece_to.content.color == :red && piece_to.content.is_king? == false && directions[direction][:column] == @total_columns-1
        piece_to.content.make_king
      end
      binding.pry
      if piece_to.content.color == :black && piece_to.content.is_king? == false && directions[direction][:column] == 0
        piece_to.content.make_king
      end

      self.render
      return true
  end


  def jump_from(piece_coords={}, direction)
      #piece_coords: Hash with values :row, :column i.e. piece_coords={row:0,column:1}
      #   direction: Symbol with positions to move i.e. ":UR" (up right), ":DR" (down right)
      piece = select_piece(piece_coords[:row],piece_coords[:column])
      piece.nil? ? return : nil
      directions = {
        :UR =>  {row: piece_coords[:row] - 2,column: piece_coords[:column] + 2},
        :DR =>  {row: piece_coords[:row] + 2,column: piece_coords[:column] + 2},
        :UL =>  {row: piece_coords[:row] - 2,column: piece_coords[:column] - 2},
        :DL =>  {row: piece_coords[:row] + 2,column: piece_coords[:column] - 2},
      }
      self.save_state
      piece_from = @board[ piece_coords[:row] ][ piece_coords[:column] ]
      piece_to   =  @board[directions[direction][:row]][directions[direction][:column]]
      piece_to.content = Marshal.load( Marshal.dump(piece_from.content) )
      piece_from.content = "x"

      self.render
      return true
  end

# move stuff


  def save_state
      @history << Marshal.load( Marshal.dump(self.board) )
      @undoArr << Marshal.load( Marshal.dump(self.board) )
      puts "movement saved"
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



  def delete_piece(piece_coords={})
      #each argument must be a hash with values :row, :column
      #return nil
      @board[ piece_coords[:row] ][ piece_coords[:column]  ].content = "x"
      nil
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
      #0 .. total_rows-1
      # (0..@total_rows-1).each do |row|
      #   #0...2
      #   (0..2).each do |cell|
      #     if cell.even? && row.even? || cell.odd? && row.odd?
      #       @board[row][cell].content = Piece.new(:red)
      #     end
      #   end
      # end
      (0..@total_rows-1).each do |row|
        # 5...    -1
        (3..@total_rows-1).each do |cell|
          if cell.even? && row.even? || cell.odd? && row.odd?
            @board[row][cell].content = Piece.new(:black)
          end
        end
      end
      @board
  end

end
