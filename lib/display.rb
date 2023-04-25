class Display
  # Handles all terminal puts:

  def welcome(name:)
		puts "Let's play #{name}!\n\n"
	end

  def hand(player:, hand:)
    puts "#{player}: #{hand}"
  end

  def score(player:, score:)
    puts "#{player} score: #{score} \n\n"
  end

  def player_prompt
    puts "Hit or Stand (H/S):"
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