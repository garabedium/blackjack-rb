class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def show_hand(player_name:)
    text = "#{player_name}: \n"
    @cards.each { |card| 
      text += "#{card.display_text} "
    }
    puts text + "\n\n"
  end

end