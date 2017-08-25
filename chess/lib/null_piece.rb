require_relative "piece"

class NullPiece < Piece
  attr_reader :location, :board

  def initialize(location=nil, board=nil)
    @location, @board = location, board
  end
end
