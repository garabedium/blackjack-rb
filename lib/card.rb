class Card
  attr_reader :suit, :rank, :value, :text

  def initialize(suit:, rank:, value:)
    @suit = suit
    @rank = rank
    @value = value
  end

  def text
    # Ex: 10♦
    "#{@rank}#{@suit}"
  end

end