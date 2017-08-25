require 'spec_helper'

require_relative '../../lib/piece'
require_relative '../../lib/pawn'

describe Piece do
  describe "create" do
    let(:piece) { Piece.create "WP" }
    it "sets color and type" do
      expect(piece).to be_a Pawn
    end
  end
end
