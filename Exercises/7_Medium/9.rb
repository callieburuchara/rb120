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

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
