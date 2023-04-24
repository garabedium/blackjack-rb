
class Player
  attr_reader :name
  attr_accessor :hand

  def initialize(name: 'Player')
    @name = name
    @hand = Hand.new
  end

  def take_card(card:)
    @hand.cards.push(card)
  end

end