# Handles all terminal puts:
class Display
  def welcome
    puts "Let's play Blackjack!\n\n"
  end

  def hand(player:, hand:)
    puts "#{player}: #{hand}"
  end

  def score(player:, score:)
    puts "#{player} score: #{score} \n\n"
  end

  def hit_stand_prompt
    puts '> Hit or Stand (H/S):'
  end

  def player_stands(player:)
    puts "#{player} stands."
  end

  def player_busts(player:)
    puts "#{player} busts!"
  end

  def player_wins(player:)
    puts "#{player} wins!"
  end

  def game_push
    puts 'Tie! Game is a push.'
  end

  def restart_prompt
    puts "\n> Play again? (Y/N):"
  end

  def invalid_input
    puts "Invalid input, please Hit (H) or Stand (S). \n\n"
  end

  def hit(player:, card:)
    puts "#{player} was dealt: #{card} \n"
  end

  def divider
    puts "\n"
  end
end