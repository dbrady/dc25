require "spec_helper"
require_relative "../../lib/board"
require_relative "../../lib/piece"

describe Board do
  let(:board) { Board.new 2 }

  describe ".new" do
   it "can be sized" do
     expect(Board.new(3).size).to eq 3
   end
  end

  describe "#size" do
    it "returns size" do
      expect(board.size).to eq 2
    end
  end

  describe "#row_divider" do
    it "renders the divider between rows" do
      expect(board.row_divider).to eq("+--+--+")
    end
  end

  describe "#to_s" do
    describe "renders the board as text" do
      example "when board is empty" do
        expect(board.to_s).to eq <<BOARD
+--+--+
|  |  |
+--+--+
|  |  |
+--+--+
BOARD
      end

      example "when a white pawn is present at a1"  do
        pawn = Piece.create "WP", "a1", board
        expect(board.to_s).to eq <<BOARD
+--+--+
|  |  |
+--+--+
|WP|  |
+--+--+
BOARD
      end
    end
  end

  describe "#add_piece" do
    let(:piece) { Piece.new(Piece::WHITE) }

    it "adds a piece to the board" do
      expect {
        board.add_piece piece, "a1"
      }.to change {
        board.pieces.size
      }.by(1)
            .and change {
        board.piece_at "a1"
      }.to piece
    end

    context "when there is already a piece on the board" do
      it "raises a BoardError"
    end
  end

  describe "#piece_at" do
    let(:piece) { Piece.new(Piece::WHITE) }

    before do
      board.add_piece piece, "a1"
    end

    context "when there is a piece on the requested square" do
      it "returns the piece" do
        expect(board.piece_at("a1")).to eq piece
      end
    end

    context "when there is no piece on that square" do
      it "returns a NullPiece"
    end

    context "when that square on out of bounds" do
      it "returns a NullPiece"
    end
  end


end
