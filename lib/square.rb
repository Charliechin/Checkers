class Square
  attr_accessor :content, :bg_color
  #@content in the future will be a constant. Only these values are allowed:
  # "x" => empty space
  # "r" => red piece

  def initialize(content = nil,bg_color = nil)

    # improve this validation
    if content.nil?
      @content = "x"
    else
      @content = content
    end

    if bg_color.nil?
      @bg_color = :black
    else
      @bg_color = bg_color
    end
  end
def has_piece?
  # returns the color of the piece in said square
  # nil if there is something else in said square
  if self.content.is_a? Piece
    piece = self.content
    return piece.get_color
  else
    nil
  end
end
  def is_empty?
    if self.content == "x"
      true
    else
      false
    end
  end
  # def get_bg_color
  #   #sholud be private?


  #   if @pos_col.even? && @pos_row.even? || @pos_col.odd? && @pos_row.odd?
  #     #colorize color library
  #     # see String.color_samples on irb for examples

  #     @color = :light_black
  #     puts "black".colorize(:background => @color)
  #   else
  #     #try light_red
  #     @color = :light_white
  #     puts "white".colorize(:light_blue).colorize(:background => @color)
  #   end
  # end

  def update_content(new_content)
    #TODO VALIDATIONS
    # MAKE IT PRIVATE!
    # if new_content is not "x", "r","b","B"... then can't update
    set_content(new_content)
  end

  # def to_s
  #   #change depending @color
  #   puts "\u{25A3}"
  #   # black
  #   puts "\u{25A2}"
  # end
  def get_history
  end

  private

  # def set_position(new_pos_x,new_pos_y)
  #   @pos_col = new_pos_x
  #   @pos_row = new_pos_y
  # end

  def set_content(new_content)
    @content = new_content
  end

end
