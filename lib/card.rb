class Card
  attr_reader :suit, :rank, :value, :display_text

  def initialize(suit:, rank:, value:)
    @suit = suit
    @rank = rank
    @value = value
  end

  def display_text
    # Ex: 10♦
    "#{@rank}#{@suit}"
  end

end