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

  def draw
    print_row(1, 2, 3)
    print_center
    print_row(4, 5, 6)
    print_center
    print_row(7, 8, 9)
  end

  def []=(key, marker)
    squares[key].marker = marker
  end

  def [](key)
    squares[key].marker
  end

  def unmarked_keys
    squares.select { |_, marker| marker.unmarked? }.keys
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      temp_squares = squares.values_at(*line)
      return temp_squares.first.marker if three_identical_markers?(temp_squares)
    end
    nil
  end

  def reset
    (1..9).each { |key| squares[key] = Square.new }
  end

  def at_risk_square_offense
    at_risk = at_risk_line(computer.marker)
    return nil if at_risk.empty?
    get_exact_at_risk_square(at_risk)
  end

  def at_risk_square_defense
    at_risk = at_risk_line(human.marker)
    return nil if at_risk.empty?
    get_exact_at_risk_square(at_risk)
  end

  private

  def print_center
    puts '-----+-----+-----'
  end

  def print_row(sq1, sq2, sq3)
    puts '     |     |'
    puts "  #{squares[sq1]}  |  #{squares[sq2]}  | #{squares[sq3]}"
    puts '     |     |'
  end

  def at_risk_line(this_marker)
    WINNING_LINES.select do |line|
      line.map { |num| squares[num].marker }.count(this_marker) == 2
    end
  end

  def get_exact_at_risk_square(array)
    array.last.select do |num|
      squares[num].marker == Square::INITIAL_MARKER
    end.first
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

class Player 
  attr_reader :name
  attr_accessor :score, :marker

  def initialize(kind_of_player)
    @marker = nil
    @score = 0
    set_name(kind_of_player)
  end

  def set_name(kind_of_player)
    system 'clear'
    if kind_of_player == :computer
      @name = %w(K9 R2D2 C3PO BB-8).sample
    else
      name = nil
      puts "Before we get started..."
      sleep 1
      loop do
        puts "What can we call you, adventurous one?"
        name = gets.chomp
        break unless name.strip.empty?
        puts "Sorry, but we reallllly need to know."
      end
      @name = name.capitalize
      puts "What a great name."
      sleep 1.5
    end
  end
end

class TTTGame
  CHOOSE = '?'
  FIRST_TO_MOVE = :human
  # FIRST_TO_MOVE options: :human, :computer, or :choose
  GRAND_WINNER_NUM = 2

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(:human)
    @computer = Player.new(:computer)
    @current_marker = FIRST_TO_MOVE
  end

  # rubocop: disable Metrics/MethodLength
  def play
    display_welcome_message
    set_markers(human, computer)

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

  def set_marker(current, other)
    if current == human
      answer = nil
      loop do
        puts "Which letter would you like to use? : X or O"
        answer = gets.chomp.upcase
        break if %w(X O).include?(answer)
        puts "Can't use that, unfortunately."
      end
      human.marker = answer
    else
      binding.pry
      other.marker == 'X' ? computer.marker = 'O' : computer.marker = 'X'
    end
  end

  def set_markers(human, computer)
    set_marker(human, human)
    set_marker(computer, human)
  end

  def joinor(array)
    return (array[0]).to_s if array.size == 1
    return array.join(' or ') if array.size == 2
    array[0..-2].join(', ') + ', or ' + (array[-1]).to_s
  end

  def display_welcome_message
    clear
    puts "Let's get started with some Tic-Tac-Toe, #{human.name}!"
    puts " "
    sleep 1
  end

  def display_goodbye_message
    puts "Thanks for playing Tic-Tac-Toe, #{human.name}! Buh-bye for now!"
  end

  def display_board
    puts "You're an #{human.marker}. #{computer.name} is an #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def current_player_moves
    if @current_marker == CHOOSE
      choose_first_player
    end
    @current_marker == human.marker ? human_moves : computer_moves
    alternate_players
  end

  def choose_first_player
    preference = nil
    loop do
      puts "Who would you like to go first, #{human.name}? " 
      puts "You? (type 'Me') or #{computer.name}? (type #{computer.name})"
      preference = gets.chomp.downcase
      break if ['me', "#{computer.name.downcase}"].include?(preference)
      puts "Your answer was unclear. Let's try that again..."
      sleep 0.5 
    end
    preference == 'me' ? @current_marker = human.marker : @current_marker = computer.marker
    current_player_moves
  end

  def alternate_players
    @current_marker = if @current_marker == human.marker
                        computer.marker
                      else
                        human.marker
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

  def offense_square
    board.at_risk_square_offense
  end

  def defense_square
    board.at_risk_square_defense
  end

  def random_square
    board.unmarked_keys.sample
  end

  def computer_moves
    if offense_square
      board[offense_square] = computer.marker
    elsif defense_square
      board[defense_square] = computer.marker
    elsif board[5] == Square::INITIAL_MARKER
      board[5] = computer.marker
    else
      board[random_square] = computer.marker
    end
  end

  def display_result_and_score
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker then    puts "You won!"
    when computer.marker then puts "#{computer.name} won!"
    else                      puts "It's a tie!"
    end

    display_score
    display_grand_winner_status
  end

  def display_score
    puts "Your score is #{human.score} " \
         "and #{computer.name}'s score is #{computer.score}."
  end

  def display_grand_winner_status
    if determine_grand_winner == human
      puts "Congratulations! You are the grand winner!!"
      reset_scores
    elsif determine_grand_winner == computer
      puts "Better luck next time...#{computer.name} is the grand winner!"
      reset_scores
    else
      puts "Who will make it to #{GRAND_WINNER_NUM} points first?"
    end
  end

  def determine_grand_winner
    if human.score == GRAND_WINNER_NUM
      human
    elsif computer.score == GRAND_WINNER_NUM
      computer
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
    if FIRST_TO_MOVE == :human
      @current_marker = human.marker
    elsif FIRST_TO_MOVE == :computer
      @current_marker = computer.marker
    else
      choose_first_player
    end
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end
end

game = TTTGame.new
game.play
