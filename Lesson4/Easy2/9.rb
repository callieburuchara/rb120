class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# If we added a play method to the Bingo class, then it
# would override the one in the Game class because
# Ruby wouldn't even look there. As soon as it found
# the class in Bingo, it would stop looking any further. 
# It would only keep going to Game if there was a super
# in the Bingo play method