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
  let(:deck) { game.deck }

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

  it 'deals the player another card and displays the dealt card' do
    game.deal_hands
    expect(player.hand.cards.size).to eq(2)

    expect { game.player_hits(player:, card: deck.deal_card) }
      .to output(game.display.message(key: 'hit', params: { player: player.name, card: player.hand.last_card.text }))
      .to_stdout

    expect(player.hand.cards.size).to eq(3)
  end

  it "deals the dealer cards until dealer's score is greater than or equal to 17'" do
    cards = deck.deck.find_all { |card| card.value < 4 }
    game.player_hits(player: dealer, card: cards[-1])
    game.player_hits(player: dealer, card: cards[-1])
    expect(dealer.score).to be < Blackjack::DEALER_HAND_MIN
    player.stand
    game.dealer_turn
    expect(dealer.score).to be >= Blackjack::DEALER_HAND_MIN
  end

  it 'does not deal the dealer additional cards if starting hand is greater than or equal to 17' do
    card_count = 2
    dealer.hit(card: deck.deck.find { |card| card.value == 10 })
    dealer.hit(card: deck.deck.find { |card| card.value == 7 })
    expect(dealer.hand.cards.size).to eq(card_count)
    game.dealer_turn
    expect(dealer.hand.cards.size).to eq(card_count)
  end

  it 'displays a tie game if both players have the same score' do
    player.hit(card: deck.deck.find { |card| card.value == 10 })
    player.hit(card: deck.deck.find { |card| card.value == 7 })
    dealer.hit(card: deck.deck.find { |card| card.value == 10 })
    dealer.hit(card: deck.deck.find { |card| card.value == 7 })
    expect(player.score).to be(17)
    expect(dealer.score).to be(17)

    expect { game.game_winner }.to output(game.display.message(key: 'game_tie', breaks: 2)).to_stdout
  end

  it 'returns a Player win if Player scores higher than Dealer' do
    player.hit(card: deck.deck.find { |card| card.value == 10 })
    player.hit(card: deck.deck.find { |card| card.value == 10 })
    dealer.hit(card: deck.deck.find { |card| card.value == 10 })
    dealer.hit(card: deck.deck.find { |card| card.value == 9 })

    expect(player.score).to be(20)
    expect(dealer.score).to be(19)
    winner = game.calc_winner
    expect { game.game_winner }
      .to output(game.display.message(key: 'player_wins', params: { player: winner }, breaks: 2))
      .to_stdout

    expect(winner).to be(player.name)
  end

  it 'returns a Dealer win if Player busts' do
    player.bust

    expect(player.busts).to be true
    expect(game.calc_winner).to be(dealer.name)
  end

  it 'returns a Player win if Dealer busts' do
    dealer.bust

    expect(dealer.busts).to be true
    expect(game.calc_winner).to be(player.name)
  end

  it 'returns a Dealer win if both Dealer and Player bust' do
    player.bust
    dealer.bust

    expect(player.busts).to be true
    expect(dealer.busts).to be true
    expect(game.calc_winner).to be(dealer.name)
  end

  it 'ends game if player busts' do
    player.hit(card: deck.deck.find { |card| card.value == 10 })
    player.hit(card: deck.deck.find { |card| card.value == 10 })
    player.hit(card: deck.deck.find { |card| card.value == 2 })

    expect(game.game_over).to be false

    expect { game.bust?(player:) }
      .to output(game.display.message(key: 'player_busts', params: { player: player.name }))
      .to_stdout

    expect(game.game_over).to be true
  end
end
