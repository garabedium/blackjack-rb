class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def get_hand
    text = ""
    @cards.each { |card|
      text += "#{card.text} "
    }
   text
  end

  def score
    @cards.reduce(0) { |score, card| score + card.value }
  end

  def last_card
    @cards[-1]
  end
end