#!/usr/bin/env bash

# Two-Player Tic-tac-toe

# Access grid,sh in parent directory
source ../grid.sh

# Create a 3x3 grid and fill with "#"
board=()
create_grid board 3 3
set_all_coords board "#"

# A turn counter, when turn is odd, X, when even, O
turn=1
# The winner (X or O), initialized as -1
winner=-1

# Show the grid
display_grid board

# Check for a winner and set winner variable to the winning player
function detect_winner {

	# check horizontal
	for i in 0 1 2; do
		if [ $(get_coord board 0 $i) == $(get_coord board 1 $i) ] && [ $(get_coord board 1 $i) == $(get_coord board 2 $i) ]; then
			if [[ $(get_coord board 0 $i) != "#" ]]; then
				winner="$(get_coord board 0 $i)"
			fi
		fi
	done

	# check vertical
	for i in 0 1 2; do
		if [ $(get_coord board $i 0) == $(get_coord board $i 1) ] && [ $(get_coord board $i 1) == $(get_coord board $i 2) ]; then
			if [[ $(get_coord board $i 0) != "#" ]]; then
				winner="$(get_coord board $i 0)"
			fi
		fi
	done

	# check diagonals
	if [ $(get_coord board 0 0) == $(get_coord board 1 1) ] && [ $(get_coord board 1 1) == $(get_coord board 2 2) ]; then
		if [[ $(get_coord board 1 1) != "#" ]]; then
				winner="$(get_coord board 1 1)"
		fi
	fi

	if [ $(get_coord board 2 0) == $(get_coord board 1 1) ] && [ $(get_coord board 1 1) == $(get_coord board 0 2) ]; then
		if [[ $(get_coord board 1 1) != "#" ]]; then
				winner="$(get_coord board 1 1)"
		fi	
	fi
}

# Get input and update grid until there is a winner
while [ $winner == -1 ]; do

	# If only one empty space and no winner, its a draw
	empty_count=$(awk -F"#" '{print NF-1}'<<< "${board[@]}")
	if [[ $empty_count -le 1 ]]; then
		break
	fi


	# Switch between X an O based on turn	
	marker="$([[ $(( $turn % 2 )) == 0 ]] && { echo O; } || { echo X; })"
	
	# Current player
	echo Player: $marker

	# Ask for x and y coords
	echo Enter x value
	tput el
	read x

	echo Enter y value
	tput el
	read y

	# Move up to right where grid ends
	tput cuu1; tput cuu1; tput cuu1; tput cuu1; tput cuu1

	# Clear old grid
	for i in 1 2 3; do
		tput cuu1
		tput el
	done

	# Put marker at specified position
	if [[ $(get_coord board $x $y) == "#" ]]; then 
		set_coord board $x $y $marker
	fi

	# Show the grid
	display_grid board

	turn=$(($turn + 1))

	# Check for winner
	detect_winner
done

# Specify winner if there is one or call a draw
[[ $winner -ne -1 ]] && { echo Winner: $winner; } || { echo It\'s a draw!; }