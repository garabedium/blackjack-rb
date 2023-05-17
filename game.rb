# frozen_string_literal: true

require_relative 'lib/blackjack'
require_relative 'lib/deck'
require_relative 'lib/card'
require_relative 'lib/hand'
require_relative 'lib/player'
require_relative 'lib/dealer'
require_relative 'lib/display'

# Lanch Blackjack game:
game = Blackjack.new
game.welcome
game.deal_hands
game.player.show_hand
game.player.show_score
game.dealer.show_hand_facedown
game.dealer.show_score_facedown
game.game_loop
game.game_restart
