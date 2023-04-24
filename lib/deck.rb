class Deck

	SUITS = ['♦', '♣', '♠', '♥']
	RANKS = [2,3,4,5,6,7,8,9,10,'J','Q','K','A']
  FACE_CARD_VALUE = 10
  ACE_CARD_VALUE = 11
  FACE_CARDS = {
    'J': FACE_CARD_VALUE,
    'Q': FACE_CARD_VALUE,
    'K': FACE_CARD_VALUE,
    'A': ACE_CARD_VALUE
  }

  def initialize()
    @deck = build_deck().shuffle
    binding.pry
  end

  def build_deck
		deck = SUITS.map { |suit|
			RANKS.map { |rank|
        card_value = FACE_CARDS[rank] || rank
				Card.new(suit: suit, rank: rank, value: card_value)
			}
		}
    deck[0]
  end

end