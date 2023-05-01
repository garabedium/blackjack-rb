require 'spec_helper'
require_relative '../../lib/blackjack'
require_relative '../../lib/deck'
require_relative '../../lib/card'
require_relative '../../lib/hand'
require_relative '../../lib/player'
require_relative '../../lib/dealer'
require_relative '../../lib/display'

describe Blackjack do
  let(:game) { Blackjack.new }
  let(:player) { game.player }
  let(:dealer) { game.dealer }

  it 'deal hands to both players' do
    expect(player.hand.cards.size).to be(0)
    expect(dealer.hand.cards.size).to be(0)
    game.deal_hands
    expect(player.hand.cards.size).to be(2)
    expect(dealer.hand.cards.size).to be(2)
  end

  it 'displays the player hands' do
    game.deal_hands
    player_hand = "#{player.name}: #{player.hand.text}\n#{player.name} score: #{player.score}\n\n"
    dealer_hand = "#{dealer.name}: #{dealer.hand.text}\n#{dealer.name} score: #{dealer.score}\n\n"

    expect { game.display_hand(player:) }.to output(player_hand).to_stdout
    expect { game.display_hand(player: dealer) }.to output(dealer_hand).to_stdout
  end
end
