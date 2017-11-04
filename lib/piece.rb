class Piece
  attr_accessor :color
  def initialize(color = nil)
    if color.nil?
      @color = :red
    else
      @color = color
    end
    @king = false
  end

  def get_color
    @color
  end

  def is_king?
    if @king
      return true
    else
      return false
    end
  end
  # Moved to Board
  # def get_position
  # Try use a hash
  # return {x: @pos_col, y: @pos_row}
  #return [@pos_col, @pos_row]
  #  end

  #  def update_position(new_col, new_row)
  #    # make private
  #    @pos_col = new_col
  #    @pos_row = new_row
  #  end

  def to_s
    if @color == 'r'
      puts "\u{1F534}"
    else
      puts "\u{1F535}"
    end
  end

  def make_king
    @king = true
  end
end
