# frozen_string_literal: true

# Person or computer playing the game
class Player
  attr_reader :name, :stands, :busts
  attr_accessor :hand

  def initialize(name: 'Player', stands: false, busts: false)
    @name = name
    @hand = Hand.new
    @stands = stands
    @busts = busts
    @display = Display.new
  end

  def take_card(card:)
    # Check for Ace before pushing card:
    if card.ace
      temp_score = @hand.score + card.value
      card.set_ace_value if temp_score > 21
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

  def score
    @hand.score
  end

  def show_hand
    @display.message(key: 'hand', params: { player: @name, hand: @hand.text })
  end

  def show_score
    @display.message(key: 'score', params: { player: @name, score: }, breaks: 2)
  end
end
