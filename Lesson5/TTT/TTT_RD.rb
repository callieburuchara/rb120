class Board 
  def initialize
    # create a blank board. Represent it the same way as last time?
    # or make a Square class and use those objects?
    # should we initialize which player is which letter here, too?
    # ohh maybe initialize players here also
  end

  def winner?
    # checks the current state of the board to see if there's a winner
  end

  def display
    #displays the current board
  end
end

class Square
  def initialize
    # maybe a status to keep track of this square's mark?
  end
end

class Player
  def initialize
    # ask the player for their name. Probably a separate method and put it here
    # "marker" to keep track of their symbol as X or O. Should that be a choice?
  end

  def mark

  end

  def play

  end
end

class TTTGame
  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end

    display_result
    display_goodbye_message
    end
  end
end

game = TTTGame.new
game.play