require_relative 'errors'

class Piece
  WHITE = :white
  BLACK = :black

  attr_reader :color, :location
  def initialize(color, location=nil)
    @color, @location = color, location
  end

  def self.create(abbrev, location=nil, board=nil)
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
    piece = klass.new(color, location)
    board.add_piece piece, location if location && board
    piece
  end

  def self.color_symbol(color)
    color == WHITE ? "W" : "B"
  end

  def to_s
    "%s%s" % [Piece.color_symbol(color), type_symbol]
  end

  def type_symbol
    raise NotImplementedError.new("Child class must override Piece#type_symbol")
  end

  def rank
    location.split(//).last.to_i
  end

  def file
    location.split(//).first
  end

  def square_ahead
    "#{file}#{next_rank}"
  end

  def next_rank
    if white?
      rank + 1
    else
      rank - 1
    end
  end

  def right_file
    (file.ord + (white? ? 1 : -1)).chr
  end

  def left_file
    (file.ord + (black? ? 1 : -1)).chr
  end

  def white?
    color == WHITE
  end

  def black?
    color == BLACK
  end

  def present?
    true
  end

  def empty?
    false
  end

  def enemy_of?(piece)
    (white? && piece.black?) ||
      (black? && piece.white?)
  end
end
