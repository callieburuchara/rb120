require 'pry'

class Board
  attr_reader :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                   [1, 4, 7], [2, 5, 8], [3, 6, 9],
                   [1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  # rubocop: disable Metrics/AbcSize, Metrics/MethodLength
  def draw
    puts"     |     |"
    puts"  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]} "
    puts"     |     |"
    puts"-----+-----+-----"
    puts"     |     |"
    puts"  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]} "
    puts"     |     |"
    puts"-----+-----+-----"
    puts"     |     |"
    puts"  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}  "
    puts"     |     |"
  end
  # rubocop: enable Metrics/AbcSize, Metrics/MethodLength

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def [](key)
    @squares[key].marker
  end

  def unmarked_keys
    @squares.select { |_, marker| marker.unmarked? }.keys
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if three_identical_markers?(squares)
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def at_risk_square_offense
    at_risk = at_risk_line(TTTGame::COMPUTER_MARKER)
    return nil if at_risk.empty?
    get_exact_at_risk_square(at_risk)
  end

  def at_risk_square_defense
    at_risk = at_risk_line(TTTGame::HUMAN_MARKER)
    return nil if at_risk.empty?
    get_exact_at_risk_square(at_risk)
  end


  private

  def at_risk_line(this_marker)
    WINNING_LINES.select do |line|
      line.map {|num| @squares[num].marker}.count(this_marker) == 2
    end
  end

  def get_exact_at_risk_square(array)
    array.first.select {|num| @squares[num].marker == Square::INITIAL_MARKER}.first
  end

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).map(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

# I could just delete the Player class and use a data structure instead
# since the class has no behaviors. But how would I do that?
class Player
  attr_reader :marker 
  attr_accessor :score

  def initialize(marker)
    @marker = marker
    @score = 0
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = HUMAN_MARKER
  GRAND_WINNER_NUM = 2

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
  end

  # rubocop: disable Metrics/MethodLength
  def play
    display_welcome_message

    loop do
      display_board

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board
      end

      update_scores
      display_result_and_score
      break unless play_again?
      reset
      display_play_again_message
    end

    display_goodbye_message
  end
  # rubocop: enable Metrics/MethodLength

  private

  def joinor(array)
    return "#{array[0]}" if array.size == 1
    return array.join(' or ') if array.size == 2
    array[0..-2].join(', ') + ', or ' + "#{array[-1]}"
  end

  def display_welcome_message
    clear
    puts "Hello person! Welcome to Tic-Tac-Toe!"
    puts " "
    sleep 1
  end

  def display_goodbye_message
    puts "Thanks for playing Tic-Tac-Toe, person! Buh-bye for now!"
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def current_player_moves
    @current_marker == HUMAN_MARKER ? human_moves : computer_moves
    alternate_players
  end

  def alternate_players
    @current_marker = if @current_marker == HUMAN_MARKER
                        COMPUTER_MARKER
                      else
                        HUMAN_MARKER
                      end
  end

  def human_moves
    square = nil
    loop do
      puts "Choose a square: #{joinor(board.unmarked_keys)}"
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def computer_moves
    if !!board.at_risk_square_offense
      board[board.at_risk_square_offense] = computer.marker
    elsif !!board.at_risk_square_defense
      board[board.at_risk_square_defense] = computer.marker
    elsif board[5] == Square::INITIAL_MARKER
      board[5] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def display_result_and_score
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker then    puts "You won!"
    when computer.marker then puts "The computer won!"
    else                      puts "It's a tie!"
    end

    puts "Your score is #{human.score} " +
         "and the computer's score is #{computer.score}."
    display_grand_winner_status
  end

  def display_grand_winner_status
    if determine_grand_winner == human
      puts "Congratulations! You are the grand winner!!"
      reset_scores
    elsif determine_grand_winner == computer
      puts "Better luck next time...Computer is the grand winner!"
      reset_scores # should this be in this method?
    else
      puts "Who will make it to #{GRAND_WINNER_NUM} points first?"
    end
  end

  def determine_grand_winner
    if human.score == GRAND_WINNER_NUM
      return human
    elsif computer.score == GRAND_WINNER_NUM
      return computer
    end
  end

  def update_scores
    case board.winning_marker
    when human.marker then     human.score += 1
    when computer.marker then  computer.score += 1
    end
  end

  def reset_scores
    human.score = 0
    computer.score = 0
  end


  def clear
    system 'clear'
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n yes no).include?(answer)
      puts "Sorry, must be (y)es or (n)o."
    end
    answer == 'y' || answer == 'yes'
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end
end

game = TTTGame.new
game.play
