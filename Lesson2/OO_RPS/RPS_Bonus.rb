class Move
  attr_reader :beats, :move

  def to_s
    @value
  end

  protected

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
    history << move.to_s
  end
end

class Human < Player
  attr_accessor :score

  def choose
    temp = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock "\
           "(by name or 'r', 'p', 'sc', 'l', or 'sp'):"
      temp = gets.chomp
      break if Player::VALS.keys.any? { |n| n == temp } ||
               Player::VALUES.include?(temp)
      puts "Sorry, invalid choice. Please try again."
    end
    self.move = VALS[VALS.select { |n| temp.start_with?(n) }.keys.first]
  end

  private
  
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
end

class Computer < Player
  attr_accessor :score, :name
end

class R2D2 < Computer
  def choose
    self.move = Rock.new
  end

  private

  def set_name
    @name = "R2D2"
  end
end

class Hal < Computer
  def choose
    self.move = [Paper.new, Paper.new, Paper.new, Lizard.new,
                 Lizard.new, Rock.new].sample
  end

  private

  def set_name
    @name = "Hal"
  end
end

class Watson < Computer
  def choose
    self.move = [Spock.new, Spock.new, Lizard.new,
                 Scissors.new, Scissors.new].sample
  end

  private

  def set_name
    @name = "Watson"
  end
end

module History
  def display_history
    return unless see_history?
    puts "#{human.name}'s history has been: #{human.history}"
    puts "#{computer.name}'s history has been: #{computer.history}"
  end

  def update_histories
    human.update_history
    computer.update_history
  end

  private

  def see_history?
    return false unless grand_winner?
    response = nil
    loop do
      puts "Would you like to see the history of moves for the players? y/n"
      response = gets.chomp
      break if ['y', 'n'].include?(response.downcase)
      puts "Please type 'y' or 'n'"
    end
    response.downcase == 'y'
  end
end

class RPSGame < Move
  include History
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

  private

  def determine_winner
    if human.move.beats?(computer.move)
      return human
    elsif computer.move.beats?(human.move)
      return computer
    end
  end

  public

  def display_winner
    if determine_winner == human
      puts "#{human.name} won!"
    elsif determine_winner == computer
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def update_scores
    if determine_winner == human
      human.score += 1
    elsif determine_winner == computer
      computer.score += 1
    end
  end

  def display_scores
    sleep 1
    puts "#{human.name}'s score is #{human.score} and " \
         "#{computer.name}'s score is #{computer.score}!"
    sleep 1
  end

  def grand_winner?
    human.num_score == Score::WIN_NUMBER ||
    computer.num_score == Score::WIN_NUMBER
  end

  def reset_scores
    return unless grand_winner?
    human.score = 0
    computer.score = 0
  end

  def display_grand_winner
    if human.num_score == Score::WIN_NUMBER
      puts "AMAZING! #{human.name} is the grand winner!!"
    elsif computer.num_score == Score::WIN_NUMBER
      puts "Gah, those computers. #{computer.name} is the grand winner!"
    else
      puts "Who shall reach #{Score::WIN_NUMBER} first??"
    end
  end

  def play_again?
    sleep 1
    answer = nil
    loop do
      puts "Would you like to play again? Type 'y' or 'n'"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Come again? Answer must by y or n."
    end
    answer.downcase == "y"
  end

  def clear_screen
    system('clear') || system('cls')
  end

  # rubocop: disable Metrics/MethodLength
  def play
    display_welcome_message
    loop do
      clear_screen
      human.choose
      computer.choose
      display_moves
      display_winner
      update_scores
      update_histories
      display_scores
      display_grand_winner
      display_history
      reset_scores
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
