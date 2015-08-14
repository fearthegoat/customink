#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'deck'

class DeckTest < Minitest::Test
  def setup
    @a = Deck.new
    @card = Card.new("Two", 2, "SPADES")
  end

  def test_card_displays_value
    assert_equal 2, @card.value
  end

  def test_card_displays_suit
    assert_equal "SPADES", @card.suit
  end

  def test_card_displays_name
    assert_equal "Two", @card.name
  end

  def test_generates_deck_of_52_cards
    assert_equal 52, @a.cards.size
  end

  def shuffle_check(deck) # needed for the shuffle deck test
    deck.cards.inject(0.0){ |result, card| result + deck.cards.index(card) * card.value }
  end

  def test_shuffle_deck
    b = Deck.new
    b.shuffle
    assert_equal false, shuffle_check(b) == shuffle_check(@a)
  end

  def test_removes_a_card_from_deck_when_drawn
    @a.draw_card
    assert_equal 51, @a.cards.size
  end

  def test_cards_correctly_created
    assert_equal 2, @a.cards.first.value
  end

  def test_dealt_card_is_removed_from_deck_when_drawn
    new_stack = StackOfCards.new
    @a.draw_card(new_stack, 1)
    drawn_card = new_stack.cards.first
    assert_equal false, @a.cards.include?(drawn_card)
  end

  def test_deals_card_to_another_stack
    new_stack = StackOfCards.new
    @a.draw_card(new_stack, 1)
    assert_equal 1, new_stack.cards.size
  end

end
