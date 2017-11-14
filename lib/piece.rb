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
    case @color
    when :red
      if self.is_king?
        "\u{1f530}"
      else
        "\u{1F534}"
      end
    when :black
      if self.is_king?
        "\u{1F536}"
      else
        "\u{1F535}"
      end
    end
  end

  def make_king
    puts "I'm a King now!"
    @king = true
  end
end
