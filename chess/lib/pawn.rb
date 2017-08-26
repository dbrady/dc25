require_relative "piece"

class Pawn < Piece
  def initialize(color, location=nil)
    super
  end

  def type_symbol
    "P"
  end

  def potential_moves board
    moves = []
    # if the square ahead is empty, I can move there
    moves << square_ahead if board.piece_at(square_ahead).empty?


    # if either diagonally-ahead square has an enemy, I can move there
    [square_ahead_left, square_ahead_right].each do |pos|
      moves << pos if board.piece_at(pos).enemy_of?(self)
    end
    moves
  end

  def square_ahead_left
    "#{left_file}#{next_rank}"
  end

  def square_ahead_right
    "#{right_file}#{next_rank}"
  end
end
