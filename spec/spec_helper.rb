require 'byebug'
require 'colorize'
require 'simplecov'

SimpleCov.start

RSpec.configure do |config|
  config.color = true
end

String.disable_colorization = true
