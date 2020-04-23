require 'pry'

class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = {'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14}

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(rank, rank) # just returns the number if a number is given. Brilliant.
  end

  def <=>(other_card)
    value <=> other_card.value
  end
end

class Deck

  def initialize
    reset
  end

  def draw
    reset if @full_deck.empty?
    @full_deck.pop
  end

  private

  def reset
    @full_deck = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end

    @full_deck.shuffle!
  end

  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
end

class PokerHand
  attr_accessor :deck, :current_hand
  
  def initialize(deck)
    @full_deck = deck
    @current_hand = []
    5.times {@current_hand << @full_deck.draw}
  end

  def print
    current_hand
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def all_values
    all_values = []
    current_hand.each {|card| all_values << card.value}
    all_values
  end

  def all_ranks
    all_ranks = []
    current_hand.each {|card| all_ranks << card.rank}
    all_ranks
  end

  def check_suit
    current_hand.first.suit
  end

  ROYAL_FLUSH = [10, 'Ace', 'Queen', 'King', 'Jack']

  def royal_flush?
    ROYAL_FLUSH.map(&:to_s).sort == all_ranks.map(&:to_s).sort && 
    current_hand.all? {|card| card.suit == check_suit}
  end

  def straight_flush?
    values = all_values
    values.sort!.select!.with_index do |num, idx|
      idx == (values.size - 1) ? true : (num == values[idx+1] - 1  )
    end
    check_suit = current_hand.first.suit
    current_hand.all? {|card| card.suit == check_suit} && 
        values.size == 5
  end

  def four_of_a_kind?
    all_ranks.count(all_ranks[0]) == 4 || all_ranks.count(all_ranks[1]) == 4
  end

  def full_house?
    (all_values.sort.count(all_values[0]) == 3 && all_values.sort.count(all_values[-1]) == 2) ||
    (all_values.sort.count(all_values[0]) == 2 && all_values.sort.count(all_values[-1]) == 3)
  end

  def flush?
    current_hand.all? {|card| card.suit == check_suit}
  end

  def straight?
    values = all_values
    values.sort!.select!.with_index do |num, idx|
      idx == (values.size - 1) ? true : num == values[idx+1] - 1  
    end
    values.size == 5
  end

  def three_of_a_kind?
    all_values.count(all_values[0]) == 3 ||
    all_values.count(all_values[2]) == 3 ||
    all_values.count(all_values[-1]) == 3
  end

  def two_pair?
    counts = {}
    all_values.each {|num| counts[num] = all_values.count(num)}
    counts.values.count(2) == 2
  end

  def pair?
    counts = {}
    all_values.each {|num| counts[num] = all_values.count(num)}
    counts.values.count(2) == 1
  end
end


hand = PokerHand.new(Deck.new)
puts hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

#Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'