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
        @player.hit(card: @deck.deal_card)
        @display.hit(player: @player.name, card: @player.hand.last_card.text)
        @display.score(player: @player.name, score: @player.score)
      elsif player_input == 's'
        @player.stand
        @display.player_stands(player: @player.name)
        @display.score(player: @player.name, score: @player.score)
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
      while @dealer.score < 17
        @dealer.hit(card: @deck.deal_card)
        @display.hit(player: @dealer.name, card: @dealer.hand.last_card.text)
        @display.score(player: @dealer.name, score: @dealer.score)
      end
    elsif @dealer.score > 17
      @dealer.stand
      @display.player_stands(player: @dealer.name)
    end
    bust?(player: @dealer)
  end

  def game_winner
    player_score = @player.score
    dealer_score = @dealer.score

    # Tie game, else calc winner:
    if player_score == dealer_score
      @display.game_push
    else
      if @dealer.busts && @player.busts || @player.busts
        winner = @dealer.name
      elsif @dealer.busts && !@player.busts
        winner = @player.name
      else
        winner = player_score > dealer_score ? @player.name : @dealer.name
      end
      @display.player_wins(player: winner)
    end

    @game_over = true
  end

  def bust?(player:)
    return unless player.score > 21

    player.bust
    @display.player_busts(player: player.name)
    @game_over = true
  end

  def game_restart
    @display.restart_prompt
    player_restart = gets.chomp.downcase

    return unless player_restart == 'y'

    load($PROGRAM_NAME)
  end
end
