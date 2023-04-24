class Deck

  attr_reader :deck

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

  def initialize
    @deck = build_deck.shuffle
  end

  def build_deck
    deck = []
		SUITS.each { |suit|
			RANKS.each { |rank|
        card_value = (rank.class == String) ? FACE_CARDS[rank.to_sym] : rank
				deck.push(Card.new(suit: suit, rank: rank, value: card_value))
			}
		}
    deck
  end

  def deal_card
    @deck.shift(1)[0]
  end

end