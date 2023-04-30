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

  it 'displays the hand' do
    game.deal_hands
    hand = ""
    expect { game.display_hand(player: player) }.to output('A♥ 9♠').to_stdout # rubocop:disable Style/HashSyntax
  end

end
