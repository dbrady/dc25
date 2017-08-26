require 'spec_helper'
require_relative '../../lib/null_piece'
require_relative '../../lib/pawn'

describe NullPiece do
  let(:board) { double }
  let(:piece) { NullPiece.new("a1", board) }

  describe "#initialize" do
    it "can be created with no arguments" do
      expect(NullPiece.new).to be_a NullPiece
    end

    it "can be created with location and board" do
      expect(piece.location).to eq "a1"
      expect(piece.board).to eq board
    end
  end

  describe "#to_s" do
    it "renders piece as blank two-character string" do
      expect(NullPiece.new.to_s).to eq "  "
    end
  end


  describe "is always empty / never present" do
    specify { expect(piece).to be_empty }
    specify { expect(piece).not_to be_present }
  end

  describe "is neither white nor black" do
    specify { expect(piece).not_to be_white }
    specify { expect(piece).not_to be_black }
  end

  describe "is not the enemy of any piece" do
    let(:white_pawn) { Piece.create "WP", "b2" }
    let(:black_pawn) { Piece.create "BP", "b2" }
    example "white" do
      expect(piece).not_to be_enemy_of(white_pawn)
    end
    example "black" do
      expect(piece).not_to be_enemy_of(black_pawn)
    end
  end
end
