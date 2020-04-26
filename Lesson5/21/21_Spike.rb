class Player
  BUST_POINTS = 21

  attr_reader :name
  attr_accessor :cards

  def initialize
    set_name
    @cards = []
  end

  def busted?
    total > BUST_POINTS
  end

  def total
    total = 0
    cards.each do |card|
      total += card.value
    end
    aces = cards.count { |card| card.rank == 'Ace' }
    aces.times do
      total -= 10 if total > BUST_POINTS
    end
    total
  end

  def hit(one_card)
    cards << one_card
  end

  def reset
    @cards = []
  end
end

class Human < Player
  def set_name
    name = nil
    loop do
      puts "Before we get started, what can we call you?"
      name = gets.chomp.strip.capitalize
      break unless name.empty?
      puts "We gotta know you! Please tell us your name?"
    end
    @name = name
  end

  def turn_choice
    choice = nil
    loop do
      puts "Would you like to hit or stay? (can also type 'h' or 's')"
      choice = gets.chomp.strip.downcase
      break if %w(hit stay h s).include?(choice)
      puts "Your answer was unclear. Let's try that again."
    end

    choice
  end
end

class Dealer < Player
  DEAL_MINIMUM = 17

  def set_name
    @name = %w(R2D2 BB-8 C3PO K-9).sample
  end
end

class Deck
  attr_reader :shuffled

  SUITS = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
  VALUES = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
  DECK = VALUES.product(SUITS).shuffle

  def initialize
    shuffle_deck
  end

  def deal(first, second)
    puts "Dealer is dealing..."
    sleep 1.5
    2.times { first.cards << shuffled.pop }
    2.times { second.cards << shuffled.pop }

    turn_arr_into_card_objects(first.cards)
    turn_arr_into_card_objects(second.cards)
  end

  def shuffle_deck
    @shuffled = DECK.shuffle
  end

  def display_current_cards(human, dealer)
    puts "-------------------------------"
    puts "Your current cards are:"
    human.cards.each { |card| puts "--> #{card}" }
    puts "with a total of #{human.total} points"
    puts "-------------------------------"
    sleep 1
    puts "Dealer has #{dealer.cards[0]} and an unknown card."
  end

  def deal_one_card
    card = shuffled.pop
    Card.new(card[0], card[1])
  end

  private

  def turn_arr_into_card_objects(array)
    array.map! do |card|
      Card.new(card[0], card[1])
    end
  end
end

class Card
  attr_reader :rank, :suit, :value

  def initialize(rank, suit)
    @suit = suit
    @rank = rank
    @value = if (2..10).cover?(rank.to_i)
               rank.to_i
             elsif %w(Jack Queen King).include?(rank)
               10
             else
               11
             end
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Game
  attr_reader :deck, :dealer, :human

  def initialize
    clear
    @deck = Deck.new
    @dealer = Dealer.new
    @human = Human.new
  end

  # rubocop: disable Metrics/MethodLength
  def play
    display_greeting

    loop do
      loop do
        deal_and_display_initial_cards
        human_turn
        break if human.busted?
        dealer_turn
        break
      end
      if_bust_display_bust_message
      display_winner
      display_scores_and_cards
      break unless play_again?
      reset
    end

    display_goodbye
  end
  # rubocop: enable Metrics/MethodLength

  private

  def prompt(words)
    puts "♣♦  #{words}  ♥♠"
  end

  def clear
    system 'clear'
  end

  def display_greeting
    prompt "Welcome to 21, #{human.name}! " \
           "We hope you're ready for a great time."
    sleep 1.5
  end

  def display_goodbye
    prompt "Thanks so much for playing, #{human.name}. See you next time!"
  end

  def deal_and_display_initial_cards
    deck.deal(human, dealer)
    deck.display_current_cards(human, dealer)
    sleep 2
  end

  def human_turn
    loop do
      choice = human.turn_choice

      human.hit(deck.deal_one_card) if %w(hit h).include?(choice)
      break if %w(stay s).include?(choice) || human.busted?
      clear
      deck.display_current_cards(human, dealer)
    end
    clear
  end

  def dealer_turn
    if dealer.total < Dealer::DEAL_MINIMUM
      puts "Dealer has to hit!"
      dealer.hit(deck.deal_one_card)
      sleep 1
      dealer_turn
    else
      puts "Dealer chose to stay!" unless dealer.busted?
    end
  end

  def if_bust_display_bust_message
    if human.busted?
      sleep 0.5
      puts "Oh no! You busted!"
    elsif dealer.busted?
      sleep 0.5
      puts "Dealer busted!"
    end
    sleep 1
  end

  def display_winner
    if someone_busted?
      human.busted? ? (puts "You won!") : (puts "Dealer won!")
    else
      dealer.total > human.total ? (puts "Dealer won!") : (puts "You won!")
    end
    sleep 1.5
  end

  def someone_busted?
    human.busted? || dealer.busted?
  end

  def display_scores_and_cards
    puts "Your cards were:"
    human.cards.each { |card| puts "--> #{card}" }
    prompt "with a total of #{human.total} points"
    sleep 1
    puts "Dealer's cards were:"
    dealer.cards.each { |card| puts "--> #{card}" }
    prompt "with a total of #{dealer.total} points"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n yes no).include?(answer)
      puts "Sorry, must be (y)es or (n)o."
    end
    %w(y yes).include?(answer)
  end

  def reset
    deck.shuffle_deck
    human.reset
    dealer.reset
    clear
    prompt "Yes! Let's play again!"
    sleep 1
  end
end

Game.new.play
