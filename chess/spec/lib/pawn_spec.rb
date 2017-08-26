require 'spec_helper'

require_relative '../../lib/piece'
require_relative '../../lib/pawn'
require_relative '../../lib/board'

describe Pawn do
  let(:pawn) { Pawn.new Piece::WHITE, "a1" }
  let(:white_pawn) { Piece.create "WP", "b2" }
  let(:black_pawn) { Piece.create "BP", "b2" }

  describe "initialize" do
    it "sets color and type" do
      expect(pawn).to be_a Pawn
      expect(pawn.color).to eq Piece::WHITE
      expect(pawn.location).to eq "a1"
    end
  end

  describe "#to_s" do
    describe "renders piece as two-character string" do
      example "when pawn is white" do
        expect(Pawn.new(Piece::WHITE).to_s).to eq "WP"
      end

      example "when pawn is black" do
        expect(Pawn.new(Piece::BLACK).to_s).to eq "BP"
      end
    end
  end

  describe "#square_ahead_left" do
    context "when piece is white" do
      it "returns location of next rank and lower file" do
        expect(white_pawn.square_ahead_left).to eq "a3"
      end
    end

    context "when piece is black" do
      it "returns location of lower rank and higher file" do
        expect(black_pawn.square_ahead_left).to eq "c1"
      end
    end
  end

  describe "#square_ahead_right" do
    context "when piece is white" do
      it "returns location of next rank and higher file" do
        expect(white_pawn.square_ahead_right).to eq "c3"
      end
    end

    context "when piece is black" do
      it "returns location of lower rank and lower file" do
        expect(black_pawn.square_ahead_right).to eq "a1"
      end
    end
  end

  describe "#potential_moves" do
    let(:board) { Board.new(2) }
    let(:pawn) { Piece.create("WP", "a1", board) }

    context "with a pawn at a1" do
      context "and no piece at a2" do
        it "can move forward" do
          expect(pawn.potential_moves(board)).to include("a2")
        end
      end

      context "and an enemy pawn at b2" do
        before do
          Piece.create("BP", "b2", board)
        end

        it "can attack b2" do
          expect(pawn.potential_moves(board)).to include("b2")
        end
      end
    end
  end
end
