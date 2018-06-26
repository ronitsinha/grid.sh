#!/usr/bin/env bash

# Access grid.sh library (in parent directory)
source ../grid.sh

# Initialize empty array for grid
grid=()

# use script args for grid dimensions
grid_width="$1"
grid_height="$2"

# Instantiate grid
create_grid grid $grid_width $grid_height

# Fill grid with "rpck"
set_all_coords grid rock
# Set value at (0, 0) to "gem"
set_coord grid 0 0 gem
# Show grid w/ borders
display_grid_fancy grid

# Show grid dimensions
echo WIDTH: $(get_grid_width grid), HEIGHT: $(get_grid_height grid)

# Newline
echo

# A second grid
grid2=()

# A new 5x3 grid
create_grid grid2 5 3
# Fill grid with value "dog"
set_all_coords grid2 dog
# Set point (4, 1) to cat
set_coord grid2 4 1 cat
# Show grid
display_grid grid2
# Show value at (3, 2)
printf "At (3, 2): "
get_coord grid2 3 2

# Show grid2 dimensions
echo WIDTH: $(get_grid_width grid2), HEIGHT: $(get_grid_height grid2)