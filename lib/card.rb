class Card
  attr_reader :suit, :rank, :value, :text, :ace
  attr_writer :set_ace_value

  def initialize(suit:, rank:, value:, ace: false)
    @suit = suit
    @rank = rank
    @value = value
    @ace = ace
  end

  def text
    # Ex: 10♦
    "#{@rank}#{@suit}"
  end

  def set_ace_value(value: 1)
    @value = value
  end

end