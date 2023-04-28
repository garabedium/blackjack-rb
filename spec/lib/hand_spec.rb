require "spec_helper"
require_relative "../../lib/deck"
require_relative "../../lib/card"
require_relative "../../lib/hand"

describe Hand do
  let(:deck) { Deck.new }
  let(:hand) { Hand.new }
  let(:cards) { deck.deck.shift(2) }

  it "shows the current cards in the hand" do
    expect(hand.cards.size).to eq(0)
    hand.cards.push(cards[0], cards[1])
    expect(hand.cards.size).to eq(2)
    cards_text = "#{cards[0].text} #{cards[1].text} "
    expect(hand.text).to eq(cards_text)
  end

  it "calculates the current hand's score" do
    cards_score = cards[0].value + cards[1].value
    hand.cards.push(cards[0], cards[1])
    expect(hand.score).to eq(cards_score)
  end
end
