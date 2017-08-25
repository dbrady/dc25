#!/usr/bin/env ruby

# puzzle 12 - Given a 3x3 chessboard with 3 white pawns at bottom and 3 white
# pawns at the top, come up with 3 moves that result in one black pawn at b1 and
# one black pawn an c2. All other squares are unknown and may contain anything.

#     +-+-+-+
#    3|.|.|.|
#     +-+-+-+
#    2|.|.|p|
#     +-+-+-+
#    1|.|p|.|
#     +-+-+-+
#      a b c

# Setup:
# Any three (legal) moves

# Sucess condition for board:
# 1. black pawn at b1
# 2. black pawn at c2

# Pawns:
# moves:
# - a pawn can move ahead (black pawns move down, white pawns move up) if the
# square ahead exists and is empty
# - a pawn can take an enemy piece diagonally ahead
# - piece.enemy?(other) returns true if piece.color != other.color
# - piece.ahead returns coords at same column, and
#   - rank + 1 if white?
#   - rank - 1 if black?

# pieces know their coordinates and/or the board knows where each piece is at
# the board can draw itself
# the board can be asked about victory conditions,
# e.g. "board.at("b1").is_a? BlackPawn" or "board.at("c1").empty?
