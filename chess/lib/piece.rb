require_relative 'errors'

class Piece
  WHITE = :white
  BLACK = :black

  attr_reader :color, :location, :board
  def initialize(color, location=nil, board=nil)
    @color, @location, @board = color, location, board
  end

  def self.create(abbrev, board=nil)
    raise InvalidPieceError.new("Piece abbreviation must be 2 characters") unless abbrev.size == 2
    color, type = *abbrev.split(//).map(&:upcase)
    raise InvalidPieceError.new("Piece color '#{color}' must be W or B") unless color =~ /^W|B$/
    raise InvalidPieceError.new("Piece type '#{type}' must be one of P,R,N,B,Q,K") unless %w(P R N B Q K).include? type

    klass = case type
            when 'P'
              Pawn
            else
              raise "Piece type '#{type}' is valid but not yet implemnted"
            end
    color = color == "W" ? WHITE : BLACK
    klass.new(color, board)
  end


end
