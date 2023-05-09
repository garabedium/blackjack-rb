# frozen_string_literal: true

# 52 Card Deck
class Deck
  attr_reader :deck

  DECK_LIMIT = 52
  SUITS = ['♦', '♣', '♠', '♥'].freeze
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze
  FACE_CARD_VALUE = 10
  ACE_CARD_VALUE = 11
  FACE_CARDS = {
    J: FACE_CARD_VALUE,
    Q: FACE_CARD_VALUE,
    K: FACE_CARD_VALUE,
    A: ACE_CARD_VALUE
  }.freeze
  SUIT_COLORS = {
    ♦: :blue,
    ♣: :green,
    ♠: :black,
    ♥: :red
  }.freeze

  def initialize
    @deck = build_deck.shuffle
  end

  def build_deck
    deck = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        # If a face card, look up value from FACE_CARDS:
        card_value = rank.instance_of?(String) ? FACE_CARDS[rank.to_sym] : rank
        ace = card_value == FACE_CARDS[:A]
        deck.push(Card.new(suit:, rank:, value: card_value, color: SUIT_COLORS[suit.to_sym], ace:))
      end
    end
    deck
  end

  def deal_card
    @deck.shift(1)[0]
  end
end
