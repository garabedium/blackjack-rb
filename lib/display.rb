class Display
  # Handles all terminal puts:

  def welcome(name:)
		puts "Let's play #{name}!\n\n"
	end

  def hand(player:, hand:)
    text = "#{player}: \n"
    text += "#{hand} \n"
    puts text
  end

  def score(score:)
    puts "Score: #{score}"
  end

  def divider
    puts "\n"
  end

end