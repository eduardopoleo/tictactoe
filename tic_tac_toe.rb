available_positions =Array(1..9)

#player chooses a move
	#move is stored in player_moves
	#move is deleted from available moves

#computer chooses a move
	#move is stored in computer_moves
	#move is deleted from availave moves

#winning combinations
	#After each move program checks if anyside has a winning combination

# Program exits when by default when there are not more avilable moves

#Initializes an empty hash with the posible positions
def initialize_board
	b={}
	(1..9).each {|position| b[position]=" "} 
	b
end
#Updates the board when either the player or the computer moves
def update_board(player_name,move,board)
	simbol=""

	if player_name=="player"
		simbol="X"
	else
		simbol="O"
	end

	board[move]=simbol
	board
end
# takes in the current state of the board and prints it
def draw_board(b)
	puts " #{b[1]} | #{b[2]} | #{b[3]}"
	puts "---+---+---"
	puts " #{b[4]} | #{b[5]} | #{b[6]}"
	puts "---+---+---"
	puts " #{b[7]} | #{b[8]} | #{b[9]}"
end
#Remove the most recently played move from the available_positions array
def update_positions(move,available_positions)
	available_positions.delete(move)
end
#Check if any of the players have a winning combination of moves.
def winnning_condition(moves_array)
	#These are the only possible winning scenarios for the game
	winning_combinations=[[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
	game_won=false
	winning_combinations.each do |combination|
		if (combination-moves_array).empty?
			game_won=true
			break
		end
	end
	return game_won
end


player_moves=[]
computer_moves=[]
winning_token=false


board=initialize_board
system "clear"
draw_board(board)

while available_positions.length!=0
	# The player gets to play his/her move
	puts "Play your move:"
	player_move=gets.chomp.to_i
	# If that move has already been played then go the next iteration
	if available_positions.include?(player_move)==false
		puts "That space is already taken"
		next
	#Otherwise stores it
	else
		player_moves << player_move
		update_positions(player_move,available_positions)
	end
	#Update board accordingly and print it
	board = update_board("player",player_move,board)
	system "clear"
	draw_board(board)
	# if the winning condition is met then "break" out of the loop
	if winnning_condition(player_moves)
		puts "You won"
		break
	end
	#computer choses a random move from the available spaces. It's stored
	computer_move=available_positions.sample
	computer_moves << computer_move
	update_positions(computer_move,available_positions)
	
	board = update_board("computer", computer_move,board)
	system "clear"
	draw_board(board)

	if winnning_condition(computer_moves)
		puts "The computer beat you"
		break
	end
	#if there is no more position available and no winner it's a draw
	if available_positions.length==0
		puts "The game is a draw"
	end
end

