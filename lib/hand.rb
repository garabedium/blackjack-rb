# frozen_string_literal: true

# Cards that a Player is holding
class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def text
    @cards.map(&:text).join(' ')
  end

  def text_facedown
    hole_card = ' [?]'
    @cards.first.text.concat(hole_card)
  end

  def score
    @cards.reduce(0) { |score, card| score + card.value }
  end

  def score_facedown
    @cards.first.value
  end

  def last_card
    @cards[-1]
  end
end
