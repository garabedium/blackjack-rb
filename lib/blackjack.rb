# Blackjack gameplay logic:
class Blackjack
  attr_reader :deck, :player, :dealer, :display, :game_over

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new(name: 'Dealer')
    @display = Display.new
    @game_over = false
  end

  def init_game
    @display.message(key: 'welcome', breaks: 2)
    deal_hands
    display_hand(player: @player)
    display_hand(player: @dealer)
    game_loop
    game_restart
  end

  def deal_hands
    deal_count = 0
    while deal_count < 2
      @player.take_card(card: @deck.deal_card)
      @dealer.take_card(card: @deck.deal_card)
      deal_count += 1
    end
  end

  # Displays hand and score for specific player:
  def display_hand(player:)
    @display.message(key: 'hand', params: { player: player.name, hand: player.hand.text })
    @display.message(key: 'score', params: { player: player.name, score: player.score }, breaks: 2)
  end

  def game_loop
    while @game_over == false
      player_turn
      dealer_turn
      game_winner
    end
  end

  def player_turn # rubocop:disable Metrics/MethodLength
    until @player.stands || @player.busts
      @display.message(key: 'prompt_hit_stand')
      player_input = user_input
      @display.divider

      if player_input == 'h'
        player_hits(player: @player)
      elsif player_input == 's'
        player_stands(player: @player)
      else
        @display.message(key: 'invalid_player_turn')
      end

      bust?(player: @player)
    end
  end

  # Hit until score is > 17, else, stand:
  def dealer_turn
    if @player.stands
      player_hits(player: @dealer) while @dealer.score < 17
    elsif @dealer.score > 17
      player_stands(player: @dealer)
    end
    bust?(player: @dealer)
  end

  def game_winner
    if @player.score == @dealer.score
      @display.message(key: 'game_tie', breaks: 2)
    else
      @display.message(key: 'player_wins', params: { player: calc_winner }, breaks: 2)
    end
    @game_over = true
  end

  def bust?(player:)
    return unless player.score > 21

    player.bust
    @display.message(key: 'player_busts', params: { player: player.name })
    @game_over = true
  end

  def player_hits(player:)
    player.hit(card: @deck.deal_card)
    @display.message(key: 'hit', params: { player: player.name, card: player.hand.last_card.text })
    @display.message(key: 'score', params: { player: player.name, score: player.score }, breaks: 2)
  end

  def player_stands(player:)
    player.stand
    @display.message(key: 'player_stands', params: { player: player.name })
    @display.message(key: 'score', params: { player: player.name, score: player.score }, breaks: 2)
  end

  def user_input
    gets.chomp.downcase
  end

  def calc_winner
    if (@dealer.busts && @player.busts) || @player.busts
      @dealer.name
    elsif @dealer.busts && !@player.busts
      @player.name
    else
      @player.score > @dealer.score ? @player.name : @dealer.name
    end
  end

  def game_restart
    @display.message(key: 'prompt_restart')
    player_input = user_input

    return unless player_input == 'y'

    load($PROGRAM_NAME)
  end
end
