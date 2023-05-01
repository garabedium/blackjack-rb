# Handles all terminal puts:
class Display
  PROMPT_BRACKET = '>'.freeze
  NEW_LINE = "\n".freeze
  MESSAGES = {
    welcome: "Let's play Blackjack!",
    hand: '%<player>s: %<hand>s',
    score: '%<player>s score: %<score>s',
    hit: '%<player>s was dealt: %<card>s',
    player_stands: '%<player>s stands.',
    player_busts: '%<player>s busts!',
    player_wins: '%<player>s wins!',
    game_tie: 'Tie! Game is a push.',
    invalid_player_turn: 'Invalid input, please Hit (H) or Stand (S)',
    prompt_hit_stand: "#{PROMPT_BRACKET} Hit or Stand (H/S):",
    prompt_restart: "#{PROMPT_BRACKET} Play again? (Y/N):"
  }.freeze

  def message(key:, params: Hash, breaks: 0)
    message = MESSAGES[key.to_sym] % params
    line_breaks = NEW_LINE * breaks
    puts "#{message}#{line_breaks}"
  end

  def divider
    puts NEW_LINE
  end
end
