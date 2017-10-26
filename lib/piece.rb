class Piece

  def initialize(pos_x,pos_y,color)
    @pos_col = pos_x
    @pos_row = pos_y
    @color = color
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

  def get_position
    # Try use a hash
    # return {x: @pos_col, y: @pos_row}
    return [@pos_col, @pos_row]
  end

  def update_position(new_col, new_row)
    # make private
    @pos_col = new_col
    @pos_row = new_row
  end

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
