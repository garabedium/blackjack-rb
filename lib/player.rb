
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