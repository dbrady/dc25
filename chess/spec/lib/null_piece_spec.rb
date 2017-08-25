require 'spec_helper'
require_relative '../../lib/null_piece'

describe NullPiece do
  describe "#initialize" do
    it "can be created with no arguments" do
      expect(NullPiece.new).to be_a NullPiece
    end

    it "can be created with location and board" do
      board = double
      piece = NullPiece.new("a1", board)
      expect(piece.location).to eq "a1"
      expect(piece.board).to eq board
    end
  end
end
