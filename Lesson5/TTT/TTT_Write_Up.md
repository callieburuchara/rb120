# DESCRIPTION OF THE PROBLEM
Tic-Tac-Toe is a two-player game that is played on a 3x3 grid. One player places
O's on the grade while the other player places Xs on the grid. The first player
to get three of their own letter in a row (whether vertically, diagonally, or
horizontally) is the winner of that round. If neither player achieves this, it
is a tie.

# NOUNS AND VERBS
NOUNS: player, marker, board, score, rules
VERBS: mark the board, check board for winner, clear board, display board

# ORGANIZE
Player
-mark the board
-play

Board
-check itself for a winner
-clear itself
-display itself

Rules
Score
Square

TTTGame <== orchestration engine class