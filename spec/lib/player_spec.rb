require 'spec_helper'

describe Player do
  let(:player1) { Player.new(name: 'Doc') }
  let(:deck) { Deck.new }
  let(:display) { Display.new }

  it "shows the player's name" do
    expect(player1.name).to eq('Doc')
  end

  it "adds a card to the player's hand" do
    expect(player1.hand.cards.size).to eq(0)
    player1.hit(card: deck.deck[0])
    expect(player1.hand.cards.size).to eq(1)
  end

  it "changes the Ace's value based on player's current score" do
    aces = deck.deck.find_all(&:ace)
    player1.hit(card: aces[0])
    expect(player1.score).to be(aces[0].value)
    player1.hit(card: aces[1])
    expect(player1.score).to be(aces[0].value + 1)
  end

  it "displays the player's hand" do
    player1.hit(card: deck.deal_card)
    player1.hit(card: deck.deal_card)
    player_hand = display.message(key: 'hand', params: { player: player1.name, hand: player1.hand.text }, breaks: 2)

    expect { player1.show_hand }.to output(player_hand).to_stdout
  end
end
