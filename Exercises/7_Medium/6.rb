class GuessingGame

  private 

  GUESS_LIMIT = 7
  RANGE = (1..100).to_a
  
  def initialize
    @guesses = GUESS_LIMIT
    @winning_number = RANGE.sample
  end

  def display_guess_amount
    if @guesses == 1
      puts "You have 1 guess remaining"
    else
      puts "You have #{@guesses} guesses remaining."
    end
    @guesses -= 1
  end

  def ask_for_number
    choice = nil
    loop do
      puts "Choose a number between #{RANGE.first} and #{RANGE.last}:"
      choice = gets.chomp.to_i
      break if RANGE.include?(choice)
      puts "Invalid guess."
    end
    @choice = choice
  end

  def respond_to_number
    if @choice > @winning_number
      puts "Your guess is too high."
    elsif @choice < @winning_number
      puts "Your guess is too low."
    else
      puts "That's the number!"
    end
  end

  def winner?
    @choice == @winning_number
  end

  def out_of_guesses?
    @guesses == 0
  end

  def display_end_message
    if winner?
      puts "You won!"
    elsif out_of_guesses?
      puts "You have no more guesses. You lost! The number was #{@winning_number}."
    end
  end

  def clear_screen
    system('clear') || system('cls')
  end  

  public

  def play
    clear_screen
    loop do
      display_guess_amount
      ask_for_number
      respond_to_number
      break if winner? || out_of_guesses?
    end
    display_end_message
  end
end

game = GuessingGame.new
game.play