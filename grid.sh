#!/usr/bin/env bash

# Initialize a grid with specified dimensions from an empty input array
function create_grid {
	# An array of strings, which represents the 2-dimensional grid
	local -n gridsh_new_grid="$1"

	# Desired grid dimensions
	local gridsh_grid_width="$2"
	local gridsh_grid_height="$3"

	# Fill the new grid with dummy values (the coordinates, i.e. 0,0)
	for i in `seq 0 $(($gridsh_grid_height - 1))`; do

		declare -a row_temp

		for j in `seq 0 $(($gridsh_grid_width - 1))`; do
			row_temp[j]="$i,$j"
		done

		gridsh_new_grid[i]="${row_temp[@]}"
	done
}

# Get height of gridsh_width_grid
function get_grid_height {
	local -n gridsh_width_grid="$1"

	echo "${#gridsh_width_grid[@]}"
}

# Get width of gridsh_height_grid
function get_grid_width {
	local -n gridsh_height_grid="$1"

	local sample=${gridsh_height_grid[0]}
	local sample_arr=($sample)

	echo "${#sample_arr[@]}"
}

# Get value at (gridsh_x_index, gridsh_y_index) of gridsh_grid
function get_coord {
	local -n gridsh_get_grid="$1"

	local gridsh_x_index="$2"
	local gridsh_y_index="$3"

	local value="$( echo ${gridsh_get_grid[$gridsh_y_index]} )"
	local value_arr=($value)

	echo ${value_arr[$gridsh_x_index]}
}

# Set value at (gridsh_x_index, gridsh_y_index) of gridsh_grid to gridsh_value
function set_coord {
	local -n gridsh_grid="$1"

	local gridsh_x_index="$2"
	local gridsh_y_index="$3"
	local gridsh_value="$4"

	local value="$(echo ${gridsh_grid[$gridsh_y_index]} )"
	local value_arr=($value)
	
	value_arr[$gridsh_x_index]=$gridsh_value

	gridsh_grid[$gridsh_y_index]=${value_arr[@]}
}

# Set all values in gridsh_grid to gridsh_value
function set_all_coords {
	local -n gridsh_grid="$1"
	local gridsh_value="$2"

	local grid_width="$(get_grid_width gridsh_grid)"
	local grid_height="$(get_grid_height gridsh_grid)"

	for i in `seq 0 $(($grid_height - 1))`; do

		declare -a row_temp

		for j in `seq 0 $(($grid_width - 1))`; do
			row_temp[$j]="$gridsh_value"
		done

		gridsh_grid[$i]="${row_temp[@]}"
	done
}

# Simply display gridsh_grid
function display_grid {
	local -n gridsh_grid="$1"

	local grid_height="$(get_grid_height gridsh_grid)"

	for i in `seq 0 $(( $grid_height - 1 ))`; do
		echo -e "${gridsh_grid[$i]}"
	done
}

# Display gridsh_grid with vertical borders between entries
function display_grid_fancy {
	local -n gridsh_grid="$1"

	local grid_height="$(get_grid_height gridsh_grid)"

	for i in `seq 0 $(( $grid_height - 1 ))`; do
		local str="${gridsh_grid[$i]}"
		echo -e "|${str// /"|"}|"
	done
}

# Get values of adjacent coordinates and return them in a space-separated string 
function get_neighbors {
	local -n gridsh_grid="$1"
	neighbors=()

	local gridsh_cx="$2"
	local gridsh_cy="$3"

	local cx=$gridsh_cx
	local cy=$gridsh_cy

	if [[ "$cy" -gt 0 ]]; then
		neighbors+=("$( get_coord gridsh_grid $cx $(($cy - 1)) )")
		if [[ "$cx" -gt 0 ]]; then
			neighbors+=("$( get_coord gridsh_grid $(($cx - 1)) $(($cy - 1)) )")
		fi

		if [[ "$cx" -lt $(( $(get_grid_width gridsh_grid) - 1 )) ]]; then
			neighbors+=("$( get_coord gridsh_grid $(($cx + 1)) $(($cy - 1)) )")	
		fi
	fi

	if [[ "$cy" -lt $(( $(get_grid_height gridsh_grid) - 1 )) ]]; then
		neighbors+=("$( get_coord gridsh_grid $cx $(($cy + 1)) )")
		if [[ "$cx" -gt 0 ]]; then
			neighbors+=("$( get_coord gridsh_grid $(($cx - 1)) $(($cy + 1)) )")
		fi

		if [[ "$cx" -lt $(( $(get_grid_width gridsh_grid) - 1 )) ]]; then
			neighbors+=("$( get_coord gridsh_grid $(($cx + 1)) $(($cy + 1)) )")	
		fi
	fi

	if [[ "$cx" -gt 0 ]]; then
		neighbors+=("$( get_coord gridsh_grid $(($cx - 1)) $cy )")
	fi

	if [[ "$cx" -lt $(( $(get_grid_width gridsh_grid) - 1 )) ]]; then
		neighbors+=("$( get_coord gridsh_grid $(($cx + 1)) $cy )")	
	fi

	echo "${neighbors[@]}"
}