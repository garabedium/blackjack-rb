# frozen_string_literal: true
require 'colorize'

# Blackjack gameplay:
class Blackjack
  attr_reader :deck, :player, :dealer, :display, :game_over

  DEALER_HAND_MIN = 17
  BLACKJACK_MAX = 21

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new(name: 'Dealer')
    @display = Display.new
    @game_over = false
  end

  def welcome
    @display.message(key: 'welcome', breaks: 2)
  end

  def deal_hands
    deal_count = 0
    while deal_count < 2
      @player.take_card(card: @deck.deal_card)
      @dealer.take_card(card: @deck.deal_card)
      deal_count += 1
    end
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
        player_hits(player: @player, card: @deck.deal_card)
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
      player_hits(player: @dealer, card: @deck.deal_card) while @dealer.score < DEALER_HAND_MIN
    elsif @dealer.score >= DEALER_HAND_MIN
      player_stands(player: @dealer)
    end
    bust?(player: @dealer)
  end

  def game_winner
    if @player.score == @dealer.score
      @display.message(key: 'game_tie', breaks: 2)
    else
      winner = calc_winner
      @display.message(key: 'player_wins', params: { player: winner.name })
      @display.message(key: 'hand', params: { player: winner.name, hand: winner.hand.text }, breaks: 2)
    end
    @game_over = true
  end

  def bust?(player:)
    return unless player.score > BLACKJACK_MAX

    player.bust
    @display.message(key: 'player_busts', params: { player: player.name }, breaks: 2)
    @game_over = true
  end

  def player_hits(player:, card:)
    player.hit(card:)
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
    if @player.busts
      @dealer
    elsif @dealer.busts && !@player.busts
      @player
    else
      @player.score > @dealer.score ? @player : @dealer
    end
  end

  def game_restart
    @display.message(key: 'prompt_restart')
    player_input = user_input

    return unless player_input == 'y'

    load($PROGRAM_NAME)
  end
end
