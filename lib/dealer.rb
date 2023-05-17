# frozen_string_literal: true

# Dealer inherits from Player class
class Dealer < Player
  def show_hand_facedown
    @display.message(key: 'hand', params: { player: @name, hand: @hand.text_facedown })
  end

  def show_score_facedown
    @display.message(key: 'score', params: { player: @name, score: @hand.score_facedown }, breaks: 2)
  end
end
