# Blackjack gameplay logic:
class Blackjack
  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new(name: 'Dealer')
    @display = Display.new
    @game_over = false

    init_game
  end

  def init_game
    @display.welcome
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
    @display.hand(player: player.name, hand: player.hand.text)
    @display.score(player: player.name, score: player.score)
  end

  def game_loop
    while @game_over == false
      player_turn
      dealer_turn
      game_winner
    end
  end

  def player_turn
    until @player.stands || @player.busts
      @display.hit_stand_prompt
      player_input = gets.chomp.downcase
      @display.divider

      if player_input == 'h'
        player_hits(player: @player)
      elsif player_input == 's'
        player_stands(player: @player)
      else
        @display.invalid_input
      end

      bust?(player: @player)
    end
  end

  # Hit until score is > 17, else, stand:
  def dealer_turn
    # return unless @player.stands
    if @player.stands
      player_hits(player: @dealer) while @dealer.score < 17
    elsif @dealer.score > 17
      player_stands(player: @dealer)
    end
    bust?(player: @dealer)
  end

  def game_winner
    # Tie game, else calc winner:
    if @player.score == @dealer.score
      @display.game_push
    else
      @display.player_wins(player: calc_winner)
    end
    @game_over = true
  end

  def bust?(player:)
    return unless player.score > 21

    player.bust
    @display.player_busts(player: player.name)
    @game_over = true
  end

  def player_hits(player:)
    player.hit(card: @deck.deal_card)
    @display.hit(player: player.name, card: player.hand.last_card.text)
    @display.score(player: player.name, score: player.score)
  end

  def player_stands(player:)
    player.stand
    @display.player_stands(player: player.name)
    @display.score(player: player.name, score: player.score)
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
    @display.restart_prompt
    player_restart = gets.chomp.downcase

    return unless player_restart == 'y'

    load($PROGRAM_NAME)
  end
end
