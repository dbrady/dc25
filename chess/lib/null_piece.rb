require_relative "piece"

class NullPiece < Piece
  attr_reader :location, :board

  def initialize(location=nil, board=nil)
    @location, @board = location, board
  end

  def to_s
    "  "
  end

  def type_symbol
    " "
  end

  def empty?
    true
  end

  def present?
    false
  end
end
