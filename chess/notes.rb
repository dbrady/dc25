# TODO

Given "a 3x3 board of pawns"
Then "the board should look like this:", <<BOARD
+--+--+--+
|BP|BP|BP|
+--+--+--+
|  |  |  |
+--+--+--+
|WP|WP|WP|
+--+--+--+
BOARD

Given "a 3x3 board of pawns"
And "an objective of a1:WP, c2:WP, a2:BP, c3:BP"
And "known white moves of 'c1 c2', 'b1 c2'"
And "a board objective of", <<BOARD
+--+--+--+
|  |  |BP|
+--+--+--+
|BP|  |WP|
+--+--+--+
|WP|  |  |
+--+--+--+
BOARD
And "a 2 move game"
When "I ask the board for black's moves to the solution"
Then "The solution should be 'b3 c2 a3 a2'"

# But... how to get there from here?

# Pieces collaborate with Boards to determine their possible moves

# Knight's general moves are "move two then over one". In the final puzzle
# (puzzle 1) white's third move is "b1 c3", which means a knight must be
# present. The board is still 3x3, however, so the knight will always only ever
# have two moves. (at b1 it can go to a1 or c3, from c3 it can go to a2 or b1,
# etc)

# Pawns are unique in that they have no general moves. They have four special
#     moves, but for the DEF CON challenge the 2-move start and capturing en
#     passant are both disabled because the boards are too small.
#
#     special move:
#         straight ahead 1 if that square is empty
#         diagonally ahead if that square contains an enemy

# Techincally, Kings have only special moves; they can move_and_attack 1 square
# in any direction but ONLY if that square is not threatened by the enemy.

# So here's the conversation. Assume a board with a white pawn (WP) at b1 and a
# black knight (BN) at c2. Board wants to know the valid moves the Pawn has.

# Board: Pawn, what are your moves?
#     Pawn: > (to myself): where am I?
#     Pawn: < I am at b1.
#     Pawn: Board, is b2 empty?
#     Board: < yes.
#     Pawn: (thinking aloud) okay, I can move to b2.
#     Pawn: (to myself): What color am I?
#     Pawn: < I am white.
#     Pawn: Board, does a2 contain an enemy of white?
#         Board: Pawn, what color are you?
#         Pawn: < I am white.
#         Board: (to myself) what piece is at a2?
#         Board: < a NullPiece.
#         Board: NullPiece, are you an enemy of white?
#         NullPiece: < No.
#     Board: < no, a2 does not contain an enemy.
#     Pawn: (thinking aloud) okay, I cannot move to a1.
#     Pawn: Board, does c2 contain an enemy of white?
#         Board: (to myself) what piece is at c2?
#         Board: < this Black Knight.
#         Board: Knight, are you an enemy of white?
#         Knight: < Yes, I am an enemy of white.
#     Board: < yes, c2 contains an enemy.
#     Pawn: (thinking aloud) okay, I can move to c2.
# Pawn: < my moves are b2 and c2.


# Rendering:
# for each tile,
#     get piece at that tile (may be a null piece)
#     send it #to_s
#     it returns its abbreviation, e.g. WP or BN (or "  " for NullPiece)
