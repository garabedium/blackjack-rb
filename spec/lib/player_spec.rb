require "spec_helper"
require_relative "../../lib/player"

describe Player do
  let(:player1) { Player.new(name: 'Doc') }
  let(:deck) { Deck.new }

  it "shows the player's name" do
    expect(player1.name).to eq('Doc')
  end

  it "adds a card to the player's hand" do
    expect(player1.hand.cards.size).to eq(0)
    player1.hit(card: deck.deck[0])
    expect(player1.hand.cards.size).to eq(1)
  end

  it "changes the Ace's value based on player's current score" do
    aces = deck.deck.find_all { |card| card.ace }
    player1.hit(card: aces[0])
    expect(player1.score).to be(aces[0].value)
    player1.hit(card: aces[1])
    expect(player1.score).to be(aces[0].value + 1)
  end

end