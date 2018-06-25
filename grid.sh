#!/bin/bash

# a set of rows, filled when create_grid() is called
declare -a rows

# The width and height of the grid, set when create_grid is called
grid_width=-1
grid_height=-1

# Initialize the grid
create_grid () {
	grid_width=$(("$1" - 1))
	grid_height=$(("$2" - 1))

	for i in `seq 0 $grid_width`; do
		declare -a col_temp
		for j in `seq 0 $grid_height`; do
			col_temp[j]="$i,$j"
		done
		rows[i]=${col_temp[*]}
	done
}

# Get the value at (x_index, y_index) in grid
get_coord () {
	x_index="$1"
	y_index="$2"

	value="$(echo ${rows[$x_index]} )"
	value_arr=($value)

	echo ${value_arr[$y_index]}
}

# Set value at (x_index, y_index) to new_value
set_coord () {
	x_index="$1"
	y_index="$2"
	new_value="$3"

	value="$(echo ${rows[$x_index]} )"
	value_arr=($value)
	value_arr[$y_index]=$new_value

	rows[$x_index]=${value_arr[*]}
}

# Set every coordinate to val
set_all_coords() {
	val="$1"

	for i in `seq 0 $grid_width`; do
		declare -a col_temp
		for j in `seq 0 $grid_height`; do
			col_temp[j]="$val"
		done
		rows[i]=${col_temp[*]}
	done
}


# Display grid in a grid format
display_grid() {
	for i in `seq 0 $grid_width`; do
		echo "${rows[$i]}"
	done
}