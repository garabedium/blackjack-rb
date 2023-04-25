
class Player
  attr_reader :name, :stands, :busts
  attr_accessor :hand

  def initialize(name: 'Player', stands: false, busts: false)
    @name = name
    @hand = Hand.new
    @stands = stands
    @busts = busts
  end

  def take_card(card:)
    # Check for Ace before pushing card:
    if card.ace
      temp_score = @hand.get_score + card.value
      if temp_score > 21
        card.set_ace_value
      end
    end
    @hand.cards.push(card)
  end

  def hit(card:)
    take_card(card:)
  end

  def stand
    @stands = !stands
  end

  def bust
    @busts = !busts
  end
end