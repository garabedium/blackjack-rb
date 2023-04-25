require 'byebug'
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
display.score(player: player.name, score: player.hand.get_score)

display.hand(player: dealer.name, hand: dealer.hand.get_hand)
display.score(player: dealer.name, score: dealer.hand.get_score)

while game_over == false
  # Player's turn:
  if !player.stands
    display.player_prompt
    player_input = gets.chomp.downcase
    display.divider

    if player_input == "h"
      player.hit(card: deck.deal_card)
      display.hit(player: player.name, card: player.hand.last_card.text)
      display.score(player: player.name, score: player.hand.get_score)
    elsif player_input == "s"
      player.stand
      display.player_stands(player: player.name)
      display.score(player: player.name, score: player.hand.get_score)
    else
      display.invalid_input
    end
  end

  # Player busts:
  if player.hand.get_score > 21
    player.bust
    display.player_busts(player: player.name)
    display.player_wins(player: dealer.name)
    game_over = true    
  end

  # Dealer's turn. Hit until score is > 17, else, stand:
  if player.stands
    if dealer.hand.get_score < 17
      while dealer.hand.get_score < 17
        dealer.hit(card: deck.deal_card)
        display.hit(player: dealer.name, card: dealer.hand.last_card.text)
        display.score(player: dealer.name, score: dealer.hand.get_score)
      end
    else
      dealer.stand
      display.player_stands(player: dealer.name)
    end
  end

  # Dealer busts:
  if dealer.hand.get_score > 21
    dealer.bust
    display.player_busts(player: dealer.name)
    display.player_wins(player: player.name)
    game_over = true
  end

  if player.stands && dealer.stands
    puts "compare score...."
    game_over = true
  end

end