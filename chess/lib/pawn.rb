require_relative "piece"

class Pawn < Piece
  def initialize(color, location=nil)
    super
  end

  def type_symbol
    "P"
  end
end
