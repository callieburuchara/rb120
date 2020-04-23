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

  def []=(key, marker)
    @squares[key].marker = marker
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
      return TTTGame::HUMAN_MARKER if
        line.all? { |num| @squares[num].marker == TTTGame::HUMAN_MARKER }
      return TTTGame::COMPUTER_MARKER if
        line.all? { |num| @squares[num].marker == TTTGame::COMPUTER_MARKER }
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
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
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
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

  def human_moves
    square = nil
    loop do
      puts "Choose a square: #{board.unmarked_keys.join(', ')}"
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker then    puts "You won!"
    when computer.marker then puts "The computer won!"
    else                      puts "It's a tie!"
    end
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
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end

  def play
    display_welcome_message

    loop do
      display_board

      loop do
        human_moves
        break if board.someone_won? || board.full?

        computer_moves
        break if board.someone_won? || board.full?

        clear_screen_and_display_board
      end
      display_result
      break unless play_again?
      reset
      display_play_again_message
    end

    display_goodbye_message
  end
end

game = TTTGame.new
game.play
