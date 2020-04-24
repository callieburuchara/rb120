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

# BONUS FEATURES
1. --DONE-- Improved 'join' (for listening available options)
--> I could go find that joinor method I wrote somewhere. Probably for 
the original TTT game
--> Or I could try to recreate it for practice...

2. --DONE--Keep score
- I don't think I need an entire score variable
- The winning_marker method is in Board, so should I put scoring there?
--> feels weird. Maybe I should make a score object...ugh
- but should add numbers to it (a hash?) based on return value of
  the winning_marker method

3. Computer AI: Defense
- if human chooses 2 squares in a row, it should select that third square
- maybe I can change the three_identical_squares to be n_identical squares
  and then pass in 3 or 2 depending on if it's checking for a win or for
  a square to defend
- or I can just make an entirely separate method to check for two squares
  in a row
- use method: find_at_risk_square

4. Computer AI: Offense
- use similar logic as defense. 
- but as seen in 5a, it can't be the same, because it should try to win if it has the chance over defending

5. Computer turn refinements
  a) have the code play offensive first
  b) 1. pick winning move 2. defend 3. pick 5 if avail, 4. pick random
  c) allow the FIRST_MOVE to change to choose if necessary
    --> if the constant is set to choose, ask the player who should go first

6. --DONE-- Alternate_players, but I already did this.  

7. Allow the player to pick X or O as their marker

8. Set a name for the player and computer
- I think we can give the computer a random name
- We can prompt the user for their own name at the very beginning
  Maybe after saying welcome. 



OFFENSE AND DEFENSE
- 