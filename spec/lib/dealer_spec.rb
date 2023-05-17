require 'spec_helper'

describe Dealer do
  let(:dealer1) { Dealer.new(name: 'Alice') }
  let(:deck) { Deck.new }
  let(:display) { Display.new }

  it "shows the dealer's faceup card" do
    dealer1.hit(card: deck.deal_card)
    dealer1.hit(card: deck.deal_card)

    dealer_hand = display.message(key: 'hand', params: { player: dealer1.name, hand: dealer1.hand.text_facedown }, breaks: 2)
    expect { dealer1.show_hand_facedown }.to output(dealer_hand).to_stdout
  end

  it "shows the dealer's faceup score" do
    dealer1.hit(card: deck.deal_card)
    dealer1.hit(card: deck.deal_card)

    dealer_score = display.message(key: 'score', params: { player: dealer1.name, score: dealer1.hand.score_facedown }, breaks: 2)
    expect { dealer1.show_score_facedown }.to output(dealer_score).to_stdout
  end
end
