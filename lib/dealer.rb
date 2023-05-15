# frozen_string_literal: true

# Dealer inherits from Player class
class Dealer < Player
  def show_faceup
    @display.message(key: 'hand', params: { player: @name, hand: @hand.text_faceup })
  end

  def show_score_faceup
    @display.message(key: 'score', params: { player: @name, score: @hand.score_faceup }, breaks: 2)
  end
end
