class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def get_hand
    text = ""
    @cards.each { |card|
      text += "#{card.display_text} "
    }
   text
  end

  def get_score
    @cards.reduce(0) { |score, card|
      score + card.value
    }
  end

end