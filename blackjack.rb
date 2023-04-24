require 'pry'
require_relative 'lib/game'
require_relative 'lib/deck'
require_relative 'lib/card'
require_relative 'lib/player'
require_relative 'lib/hand'
require_relative 'lib/dealer'

# Instantiate Game, Deck, Players:
game = Game.new
deck = Deck.new
player = Player.new
dealer = Dealer.new(name: 'Dealer')

# Welcome prompt
puts game.welcome

# Deal initial hands to players one at a time, alternating between player, dealer:
deal_count = 0;
while (deal_count < 2)
  player.take_card(card: deck.deal_card)
  dealer.take_card(card: deck.deal_card)
  deal_count += 1
end

# Display initial hands:
player.hand.show_hand(player_name: player.name)
dealer.hand.show_hand(player_name: dealer.name)
