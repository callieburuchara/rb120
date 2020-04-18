require 'pry'

class Move
  attr_reader :beats, :move
  
  def to_s
    @value
  end

  def beats?(other_move)
    @beats.include?(other_move.to_s)
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
    @beats = ['lizard', 'scissors']
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
    @beats = ['rock', 'spock']
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
    @beats = ['paper', 'lizard']
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
    @beats = ['spock', 'paper']
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
    @beats = ['scissors', 'rock']
  end
end

class Score
  WIN_NUMBER = 2

  attr_accessor :score

  def initialize
    self.score = 0
  end

  def to_s
    (score).to_s
  end

  def +(num)
    self.score += num
  end
end

class Player
  VALUES = %w(rock paper scissors lizard spock)

  VALS = {
    'r' => Rock.new,
    'p' => Paper.new,
    'sc' => Scissors.new,
    'l' => Lizard.new,
    'sp' => Spock.new
  }

  attr_accessor :name, :score, :move, :history

  def initialize
    set_name
    @score = Score.new
    @history = []
  end

  def num_score
    self.score.to_s.to_i
  end

  def update_history
    history << self.move.to_s
  end
end

class Human < Player
  attr_accessor :score

  def set_name
    n = ''
    loop do
      puts "Hi there! What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    temp = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock "+
      "(or a first letter of the options):"
      temp = gets.chomp
      break if Player::VALS.keys.any? {|n| n == temp} ||
        Player::VALUES.include?(temp)
      puts "Sorry, invalid choice. Please try again."
    end

    choice = VALS.select {|n| temp.start_with?(n)}.keys.first
    self.move = VALS[choice]
  end
end

class Computer < Player
  attr_accessor :score, :name
end

class R2D2 < Computer
  
  def set_name
    @name = "R2D2"
  end
  
  def choose
    self.move = Rock.new
  end
end

class Hal < Computer
  def set_name
    @name = "Hal"
  end  
  def choose
    self.move = [Paper.new, Paper.new, Paper.new, Lizard.new,
       Lizard.new, Rock.new].sample
  end
end

class Watson < Computer
  def set_name
    @name = "Watson"
  end  
  def choose
    self.move = [Spock.new, Spock.new, Lizard.new,
       Scissors.new, Scissors.new].sample
  end
end

class RPSGame
  attr_accessor :human, :computer, :history

  def initialize
    @human = Human.new
    @computer = [R2D2.new, Hal.new, Watson.new].sample
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock...#{human.name}!"
  end

  def display_goodbye_message
    sleep 1
    puts "Thanks for playing, #{human.name}! Buh-bye!"
  end

  def display_moves
    sleep 1
    puts "#{human.name} chose #{human.move}."
    sleep 1
    puts "#{computer.name} chose #{computer.move}."
    sleep 1
  end

  def display_winner_update_scores
    if human.move.beats?(computer.move)
        puts "#{human.name} won!"
      human.score += 1
    elsif computer.move.beats?(human.move)
      puts "#{computer.name} won!"
      computer.score += 1
    else
      puts "It's a tie!"
    end
  end

  def display_history?
    response = nil
    loop do
      puts "Would you like to see the history of moves for the players? Y/N"
      response = gets.chomp
      break if ['y', 'n'].include?(response.downcase)
      puts "Please type 'y' or 'n'"
    end
    if response.downcase == 'y'
        puts "#{human.name}'s history has been: #{human.history}"
      puts "#{computer.name}'s history has been: #{computer.history}"
    end
  end

  def display_scores
    sleep 1
    puts "#{human.name}'s score is #{human.score} and " \
         "#{computer.name}'s score is #{computer.score}!"
  end

  def display_grand_winner
    sleep 1
    if human.num_score == Score::WIN_NUMBER
      puts "AMAZING! #{human.name} is the grand winner!!"
      display_history?
      human.score = 0
      computer.score = 0
    elsif computer.num_score == Score::WIN_NUMBER
      puts "Gah, those computers. #{computer.name} is the grand winner!"
      display_history?
      human.score = 0
      computer.score = 0
    else
      puts "Who shall reach #{Score::WIN_NUMBER} first??"
    end
  end

  def play_again?
    sleep 1.5
    answer = nil
    loop do
      puts "Would you like to play again? Type 'y' or 'n'"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Come again? Answer must by y or n."
    end
    answer == "y"
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def play
    display_welcome_message
    loop do
      clear_screen
      human.choose
      computer.choose
      display_moves
      display_winner_update_scores
      human.update_history
      computer.update_history
      display_scores
      display_grand_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
