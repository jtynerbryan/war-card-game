class War
	def initialize
		@cards = [{'face_value' => '2', 'numeric_value' => 2}, 
			{'face_value' => '3', 'numeric_value' => 3}, 
			{'face_value' => '4', 'numeric_value' => 4}, 
			{'face_value' => '5', 'numeric_value' => 5}, 
			{'face_value' => '6', 'numeric_value' => 6}, 
			{'face_value' => '7', 'numeric_value' => 7}, 
			{'face_value' => '8', 'numeric_value' => 8}, 
			{'face_value' => '9', 'numeric_value' => 9}, 
			{'face_value' => '10', 'numeric_value' => 10}, 
			{'face_value' => 'Jack', 'numeric_value' => 11}, 
			{'face_value' => 'Queen', 'numeric_value' => 12}, 
			{'face_value' => 'King', 'numeric_value' => 13}, 
			{'face_value' => 'Ace', 'numeric_value' => 14}
		]
		@deck = []
		@pile = []
		@player_one = []
		@player_two = []
		@rounds = 1
	end

	# create a full deck by pushing each card in @card to the @deck 4 times

	def build_deck 
		@cards.each do |c|
			4.times do
				@deck.push(c)
			end
		end
	end

	# shuffle the 52 card deck

	def shuffle_deck 
		puts "Shuffling Deck..."
		@deck = @deck.shuffle
		puts "The Deck has been shuffled."
	end

	# split the shuffled deck evenly into 2 decks for each player

	def split_deck 
		puts "Splitting the deck..."
		while @deck.length > 0
			@player_one.push(@deck.shift)
			@player_two.push(@deck.shift)
		end
		puts "The Deck has been split."
	end

	# check to see if either player has run out of cards

	def over? 
		@player_one.empty? || @player_two.empty?
	end

	# if a player has won, announce their victory

	def winner 
		if @player_two.empty? && !@player_one.empty?
			puts "Player One has won this game of War, defeating Player One in #{@rounds} rounds."
		elsif !@player_two.empty? && @player_one.empty?
			puts "Player Two has won this game of War, defeating Player Two in #{@rounds} rounds."
		end
	end

	# show each player's card for the round

	def play_cards 
		if over?
			return
		else
			puts "Player one plays a #{@player_one[0]['face_value']}."
			puts "Player two plays a #{@player_two[0]['face_value']}."
		end
	end

	# if there's #war, each player plays a card face down, then add them to the @pile.

	def face_down 
		if over?
			return
		else
			puts "Both players play a card face down."
			@pile.push(@player_one.shift, @player_two.shift)
		end
	end

	# when the cards played are not equal, push them the player who has the higher value card

	def battle 
		if  @player_one[0]['numeric_value'] > @player_two[0]['numeric_value']
			@pile.push(@player_one.shift, @player_two.shift)
			puts "Player one wins this battle."
			while @pile.length > 0
				@player_one.push(@pile.shift)
			end
		elsif @player_two[0]['numeric_value'] > @player_one[0]['numeric_value']
			@pile.push(@player_one.shift, @player_two.shift)
			puts "Player two wins this battle."
			while @pile.length > 0
				@player_two.push(@pile.shift)
			end
		end
	end

	# if the cards played are of equal value, play a card each face down, then compare the next two cards.
	# if their of equal value again, repeat #war, otherwise push the pile to the playe with the higher value card

	def war 
		face_down
		if over?
			return
		end
		play_cards
		if  @player_one[0]['numeric_value'] == @player_two[0]['numeric_value']
			@pile.push(@player_one.shift, @player_two.shift)
			war
		elsif @player_one[0]['numeric_value'] > @player_two[0]['numeric_value']
			@pile.push(@player_one.shift, @player_two.shift)
			puts "Player one wins #{@pile.length} cards this war."
			while @pile.length > 0
				@player_one.push(@pile.shift)
			end
		elsif @player_two[0]['numeric_value'] > @player_one[0]['numeric_value']
			@pile.push(@player_one.shift, @player_two.shift)
			puts "Player two wins #{@pile.length} cards this war."
			while @pile.length > 0
				@player_two.push(@pile.shift)
			end
		end
	end

	# Run the game until someone wins, or until it's clear that no one can win

	def full_game
		build_deck
		shuffle_deck
		split_deck
		while !over? && @rounds < 10000
			puts "Round #{@rounds}"
			play_cards
			if @player_one[0]['numeric_value'] != @player_two[0]['numeric_value']
				battle
				puts "Score:"
				puts @player_one.length
				puts @player_two.length
			else
				puts "War!"
				@pile.push(@player_one.shift, @player_two.shift)
				war
				puts "Score:"
				puts @player_one.length
				puts @player_two.length
			end
			@rounds += 1
		end
		if !over? && @rounds == 10000
			puts "This War has reached a stalemate"
		else
			winner
		end
	end

end













