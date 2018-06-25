#!/usr/bin/env bash
source grid.sh

create_grid $1 $2
set_all_coords $3
# set_coord 0 1 2
display_grid

echo WIDTH:$(($grid_width+1)), HEIGHT:$(($grid_height + 1))