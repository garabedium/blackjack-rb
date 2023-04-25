class Display
  # Handles all terminal puts:

  def welcome(name:)
		puts "Let's play #{name}!\n\n"
	end

  def hand(player:, hand:)
    puts "#{player}: \n #{hand}"
  end

  def score(score:)
    puts "Score: #{score} \n\n"
  end

  def player_prompt
    puts "Hit or Stand (H/S):"
  end

  def player_stands(player:, score:)
    puts "#{player} stands. \n #{score(score: score)}"
  end

  def player_busts(player:)
    puts "#{player} busts!"
  end

  def invalid_input
    puts "Invalid input, please Hit (H) or Stand (S). \n\n"
  end

  def hit_card(card:)
    puts "\nPlayer was dealt: #{card} \n"
  end

  def divider
    puts "\n"
  end

end