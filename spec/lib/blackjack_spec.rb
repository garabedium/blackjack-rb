require 'spec_helper'

describe Blackjack do # rubocop:disable Metrics/BlockLength
  let(:game) { Blackjack.new }
  let(:player) { game.player }
  let(:dealer) { game.dealer }
  let(:deck) { game.deck }

  describe ':welcome' do
    it 'displays a welcome message to the player' do
      expect { game.welcome }.to output(game.display.message(key: 'welcome', breaks: 2)).to_stdout
    end
  end

  describe ':player_turn' do
    it 'displays a prompt for player to hit or stand' do
      allow(game).to receive(:user_input).and_return('s')

      expect { game.player_turn }.to output(game.display.message(key: 'prompt_hit_stand')).to_stdout
    end

    it 'displays a message when invalid player input is entered' do
      allow(game).to receive(:user_input).and_return('x', 's')

      expect { game.player_turn }.to output(game.display.message(key: 'invalid_player_turn')).to_stdout
    end

    it "deals a card when user types 'h' until user busts" do
      allow(game).to receive(:user_input).and_return('h')

      expect { game.player_turn }
        .to output(game.display.message(key: 'player_busts', params: { player: player.name })).to_stdout
    end
  end

  describe ':deal_hands' do
    it 'deal hands to both players' do
      expect(player.hand.cards.size).to be(0)
      expect(dealer.hand.cards.size).to be(0)
      game.deal_hands
      expect(player.hand.cards.size).to be(2)
      expect(dealer.hand.cards.size).to be(2)
    end

    it 'deals the player another card and displays the dealt card' do
      game.deal_hands
      expect(player.hand.cards.size).to eq(2)

      expect { game.player_hits(player:, card: deck.deal_card) }
        .to output(game.display.message(key: 'hit', params: { player: player.name, card: player.hand.last_card.text }))
        .to_stdout

      expect(player.hand.cards.size).to eq(3)
    end
  end

  describe ':dealer_turn' do
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
  end

  describe ':game_winner' do # rubocop:disable Metrics/BlockLength
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
        .to output(game.display.message(key: 'player_wins', params: { player: winner.name }, breaks: 2))
        .to_stdout

      expect(winner.name).to be(player.name)
    end

    it 'returns a Dealer win if Player busts' do
      player.bust

      expect(player.busts).to be true

      winner = game.calc_winner
      expect { game.game_winner }
        .to output(game.display.message(key: 'player_wins', params: { player: winner.name }, breaks: 2))
        .to_stdout

      expect(winner.name).to be(dealer.name)
    end

    it 'returns a Player win if Dealer busts' do
      dealer.bust

      expect(dealer.busts).to be true
      expect(game.calc_winner.name).to be(player.name)
    end

    it 'returns a Dealer win if both Dealer and Player bust' do
      player.bust
      dealer.bust

      expect(player.busts).to be true
      expect(dealer.busts).to be true
      expect(game.calc_winner.name).to be(dealer.name)
    end
  end

  describe ':bust?' do
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

  describe ':game_restart' do
    it 'displays a prompt for player to restart the game' do
      allow(game).to receive(:user_input)

      expect { game.game_restart }.to output(game.display.message(key: 'prompt_restart')).to_stdout
    end
  end
end
