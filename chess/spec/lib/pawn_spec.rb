require 'spec_helper'

require_relative '../../lib/piece'
require_relative '../../lib/pawn'

describe Pawn do
  let(:pawn) { Pawn.new Piece::WHITE, "a1" }

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
end
