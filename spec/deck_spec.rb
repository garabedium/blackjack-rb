require "spec_helper"
require_relative "../lib/deck"

describe Deck do
  let(:deck) { Deck.new }

  it "builds a 52 card deck" do
    expect(deck.deck.size).to eq(52)
    expect(deck.deck.first).to be_a Card
  end

  it "deals a card from the deck" do
    expect(deck.deck.size).to eq(52)
    deck.deal_card
    expect(deck.deck.size).to eq(51)
  end
end
