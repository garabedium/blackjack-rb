class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def text
    text = ''
    @cards.each { |card| text += "#{card.text} " }
    text.strip
  end

  def score
    @cards.reduce(0) { |score, card| score + card.value }
  end

  def last_card
    @cards[-1]
  end
end