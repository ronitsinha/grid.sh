# grid.sh
grid.sh is a simple bash library for creating and manipulating 2-dimensional grids without heavily using arrays.

example usage (see `examples/` for more):
```sh
#!/usr/bin/env bash

# access grid.sh library (assuming it is in the same directory)
source grid.sh

# initialize empty array for grid
my_grid=()

# Create a 3x4 grid from empty array
create_grid my_grid 3 4

# Set all values in my_grid to 1
set_all_coords my_grid 1

# Set value at (0, 1) in grid to happy
set_coord my_grid 0 1 happy

# Get value at (0, 0) in grid
get_coord my_grid 0 0

# Show my_grid
display_grid my_grid
```

**Side note:** when using this library, do not make any variables with the prefix `gridsh_`. This will prevent [circular name reference](http://mywiki.wooledge.org/BashFAQ/048#line-120 "Circular Name Reference").