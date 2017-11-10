class Piece
  attr_accessor :color
  def initialize(color = nil)
    if color == :red
      @color = :red
    else
      @color = :black
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

  def to_s
    if @color == :red
       "\u{1F534}"
    else
       "\u{1F535}"
    end
  end

  def make_king
    @king = true
  end
end
