require 'pry'
require_relative 'lib/game'
require_relative 'lib/deck'
require_relative 'lib/card'
require_relative 'lib/player'
require_relative 'lib/hand'
require_relative 'lib/dealer'
require_relative 'lib/display'

# Instantiate Game, Deck, Players:
game = Game.new
deck = Deck.new
player = Player.new
dealer = Dealer.new(name: 'Dealer')
display = Display.new

game_over = false

display.welcome(name: game.name)

# Deal initial hands to players one at a time, alternating between player, dealer:
deal_count = 0;
while (deal_count < 2)
  player.take_card(card: deck.deal_card)
  dealer.take_card(card: deck.deal_card)
  deal_count += 1
end

# Display initial hands:
display.hand(player: player.name, hand: player.hand.get_hand)
display.score(score: player.hand.get_score)

display.hand(player: dealer.name, hand: dealer.hand.get_hand)
display.score(score: dealer.hand.get_score)

while game_over == false
  display.player_prompt
  player_input = gets.chomp.downcase

  if player_input == "h"
    player.hit(card: deck.deal_card)
    display.hit_card(card: player.hand.last_card.text)
    display.score(score: player.hand.get_score)
  elsif player_input == "s"
    player.stand
    puts display.player_stands(player: player.name, score: player.hand.get_score)
  else
    display.invalid_input
  end

end