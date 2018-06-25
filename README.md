# grid.sh
grid.sh is a simple bash library for creating and manipulating 2-dimensional grids without directly using arrays.

example usage (also see `example.sh`):
```sh
#!/usr/bin/env sh

# access grid.sh library (assuming it is in the same directory)
source grid.sh

# Create a 3x4 grid
create_grid 3 4

# Set all values in grid to 1
set_all_coords 1

# Set value at (0, 1) in grid to 2
set_coord 0 1 2

# Get value at (0, 0) in grid
get_coord 0 0
```