#!/usr/bin/env ruby
# board.rb - Chess board class
require_relative 'null_piece'

class Board
  attr_reader :size, :pieces, :board

  def initialize(size)
    @size = size
    @pieces = []
    @board = []
    size.times do |rank|
      @board[rank] = []
      size.times do |file|
        @board[rank][file] = NullPiece.new
      end
    end
  end

  def to_s
    output = []
    output << row_divider
    size.times do |rank|
      output << '|' + "  |" * size
      output << row_divider
    end
    output * "\n" + "\n"
  end

  def row_divider
    '+' + "--+" * size
  end

  def add_piece piece, location
    self.pieces << piece
    x,y = *translate_location_to_xy(location)
    board[y][x] = piece
  end

  def piece_at(location)
    x,y = *translate_location_to_xy(location)
    board[y][x]
  end

  private

  def translate_location_to_xy location
    raise InvalidLocationError.new("location '#{location}' must be 2 characters") unless location.size == 2
    file, rank = location.split(//)
    file.downcase!
    if file < 'a' || file > max_rank
      raise InvalidLocationError.new("location '#{location}' must begin with a file a-#{max_rank}")
    end
    if rank < '1' || rank > size.to_s
      raise InvalidLocationError.new("location '#{location}' must end with a rank 1-#{size}")
    end
    file = file.ord - 'a'.ord + 1
    rank = rank.to_i

    [file, rank]
  end

  def max_rank
    ('a'..'h').to_a.first(size).last
  end
end
