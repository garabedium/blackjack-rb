class Game

	attr_reader :name

	def initialize(name = 'Blackjack')
		@name = name
	end

	def welcome
		"Let's play #{@name}!\n\n"
	end

end