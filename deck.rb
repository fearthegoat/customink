class Card

  # accessor since value might need to be set for aces(1 or 11)
  attr_accessor :value

  #reader since the name/suit shouldn't need to be changed
  attr_reader :name
  attr_reader :suit

  def initialize(name, value, suit)
    @name = name
    @suit = suit
    @value = value
  end

  # for a more readable output
  def to_s
    "#{@name} of #{@suit}"
  end
end

# Class for creating other stacks when cards are dealt from a Deck
class StackOfCards
  attr_reader :cards

  def initialize
    @cards = []
  end

  def shuffle
    @cards.shuffle!
  end

  def add_card(card)
    @cards << card
  end

  def set_ace_value_to_1
    @cards.each do |card|
      card.value = 1 if card.name == "Ace"
    end
  end

  def count
    @cards.count
  end

  def total_value
    @cards.inject(0) { |total, card| total + card.value }
  end

  def draw_card
    card = @cards.shift
    card
  end

  def deal_card_off_top(other_stack = StackOfCards.new, number_of_cards = 1)
    number_of_cards.times do
      card = @cards.shift
      other_stack.add_card(card)
    end
  end

end


class Deck < StackOfCards
  SUITS = "Spades", "Clubs", "Diamonds", "Hearts"
  NAMES =  "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King", "Ace"

  def initialize
    super # removes initialize duplication
    SUITS.each do |s|
      NAMES.each.with_index do | name, index|
        index += 2 # Needed since index starts at 0 and card values start at 2.
        index >= 10 ? index = 10 : index
        name == "Ace" ? index = 11 : nil
        @cards << Card.new(name, index, s)
      end
    end
    @cards
  end

end
