=> GAME FLOW
- user makes a choice
- computer makes a choice
- winner is displayed

=> APPROACH TO OOP
- Write a textual description of the problem or exercise
- Extract the major nouns and verbs from the description
- Organize and associate verbs with the nouns
- The nouns are classes and the verbs are the behaviors or methods

=> TEXTUAL DESCRIPTION
Rock, Paper, Scissors is a two-player game where each player chooses one of
three possible moves: rock, paper, or scissors. The chosen moves will then be
compared to see who wins, according to the following rules:
- rock beats scissors
- scissors beats paper
- paper beats rock
(If the players choose the same move, it's a tie)


=> FIND MAJOR NOUNS AND VERBS
Nouns: player, move, rule
(rock, paper, or scissors would all be variations, or instances (objects!) of `move`)
Verbs: choose, compare, win, lose, tie

=> ORGANIZE NOUNS AND VERBS
Player --> choose
Move 
Rule
--> compare


## BONUS FEATURES

=> KEEPING SCORE >>DONE<<
-made Score class and its instance methods
-scores are initialized with a Player object
-scores add 1 if they win, add nothing if it's a tie
-grand winner is displayed when WIN_NUMBER constant is reached
-when there's a grand winner, scores are reset to zero for another full match


=> ADD LIZARD AND SPOCK >>DONE<<
- add lizard and spock to VALUES and then the if/else logic of move (also make a
  spock? and lizard? methods in there, too)


=> ADD A CLASS FOR EACH MOVE >>DONE<<

Rock > Lizard && Scissors
Paper > Rock && Spock
Scissors > Paper && Lizard
Lizard > Spock && Paper
Spock > Scissors && Rock


=> KEEP TRACK OF A HISTORY OF MOVES >>DONE<<
- and give the option to display them after a grand winner is given

=> COMPUTER PERSONALITIES
-R2D2
> always chooses rock

-Hal
> usually paper, rarely rock

-Watson
> loves spock and lizard and scissors 

=> ALLOW FIRST LETTER OF WORD FOR SELECTION OF MOVE >>DONE<<

