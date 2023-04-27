require "spec_helper"
require_relative "../lib/deck"
require_relative "../lib/card"

describe Deck do
  let(:deck) { Deck.new }

  it "builds a 52 card deck" do
    expect(deck.deck.size).to eq(Deck::DECK_LIMIT)
    expect(deck.deck.first).to be_a Card
  end

  it "deals a single card from the deck" do
    expect(deck.deck.size).to eq(Deck::DECK_LIMIT)
    deck.deal_card
    expect(deck.deck.size).to eq(Deck::DECK_LIMIT - 1)
  end
end
