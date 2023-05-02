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
game.init_game
