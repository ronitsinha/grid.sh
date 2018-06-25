#!/usr/bin/env sh
source grid.sh

create_grid $1 $2
set_all_coords $3
display_grid

echo WIDTH:$grid_width, HEIGHT: $grid_height