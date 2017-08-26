require 'spec_helper'

require_relative '../../lib/piece'
require_relative '../../lib/pawn'

describe Piece do
  let(:white_pawn) { Piece.create "WP", "b2" }
  let(:black_pawn) { Piece.create "BP", "b2" }

  describe "create" do
    let(:piece) { Piece.create "WP" }

    it "sets color and type" do
      expect(piece).to be_a Pawn
    end
  end

  describe "#white?" do
    example "when piece is white" do
      expect(white_pawn).to be_white
    end
    example "when piece is black" do
      expect(black_pawn).not_to be_white
    end
  end

  describe "#black?" do
    example "when piece is white" do
      expect(white_pawn).not_to be_black
    end
    example "when piece is black" do
      expect(black_pawn).to be_black
    end
  end

  describe "#next_rank" do
    context "when piece is white" do
      it "returns next higher rank" do
        expect(white_pawn.next_rank).to eq 3
      end
    end

    context "when piece is black" do
      it "returns next higher rank" do
        expect(black_pawn.next_rank).to eq 1
      end
    end
  end

  describe "#right_file" do
    context "when piece is white" do
      it "returns next higher file" do
        expect(white_pawn.right_file).to eq "c"
      end
    end

    context "when piece is black" do
      it "returns next lower file" do
        expect(black_pawn.right_file).to eq "a"
      end
    end
  end

  describe "#left_file" do
    context "when piece is white" do
      it "returns next lower file" do
        expect(white_pawn.left_file).to eq "a"
      end
    end

    context "when piece is black" do
      it "returns next higher file" do
        expect(black_pawn.left_file).to eq "c"
      end
    end
  end

  describe "#square_ahead" do
    context "when piece is white" do
      it "returns location of next rank and same file" do
        expect(white_pawn.square_ahead).to eq "b3"
      end
    end

    context "when piece is black" do
      it "returns location of lower rank and same file" do
        expect(black_pawn.square_ahead).to eq "b1"
      end
    end
  end

  specify { expect(white_pawn).not_to be_empty }
  specify { expect(white_pawn).to be_present }

  describe "#enemy_of?" do
    context "when other piece is opposite color" do
      it "returns true" do
        expect(white_pawn).to be_enemy_of(black_pawn)
      end
    end

    context "when other piece is same color" do
      it "returns false" do
        expect(white_pawn).not_to be_enemy_of(white_pawn)
      end
    end

    context "when other piece is a NullPiece" do
      it "returns false" do
        null_piece = NullPiece.new("a1")
        expect(white_pawn).not_to be_enemy_of(null_piece)
        expect(black_pawn).not_to be_enemy_of(null_piece)
      end
    end
  end
end
