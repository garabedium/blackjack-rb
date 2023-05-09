# frozen_string_literal: true

# Playing Card
class Card
  attr_reader :suit, :rank, :value, :ace
  attr_writer :set_ace_value

  def initialize(suit:, rank:, value:, color: :black, ace: false)
    @suit = suit
    @rank = rank
    @value = value
    @ace = ace
    @color = color
  end

  def text
    # Ex: 10♦
    "#{@rank}#{@suit}".colorize(color: @color)
  end

  def set_ace_value(value: 1)
    @value = value
  end
end
