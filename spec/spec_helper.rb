require 'byebug'
require 'colorize'
require 'simplecov'

SimpleCov.start

require_relative '../lib/blackjack'
require_relative '../lib/deck'
require_relative '../lib/card'
require_relative '../lib/hand'
require_relative '../lib/player'
require_relative '../lib/dealer'
require_relative '../lib/display'

require 'rspec/mocks/standalone'

# Ignore text colorization for tests
String.disable_colorization = true
