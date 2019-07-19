#!/bin/bash

# fail fast bash settings
set -euo pipefail

# assuming we are running in PERMANENT
# assuming we are in the same directory as the script
# (perhaps move outside of this file to be more general)
./run_grass_pops_t10x10.sh

# special mapset for R results to avoid name clashes
g.mapset mapset=r -c

# use the computational region based on the GRASS GIS outputs
g.region raster=probability@PERMANENT

# 
r.import outputs/data/output_t10x10/probability.tif  out=probability_01

# currently getting tifs without (the original) reference 
# so stretch the raster according to what we already set as a region
# based on the other data
r.region map=probability_01 -c

# In GRASS GIS we are using 0-100 range for probability and the internal
# representation is integer, so do the same conversions.
# However, the GRASS GIS outputs are currently DCELL, so convert
# to double at the end.
r.mapcalc "probability = double(int(100 * probability_01))"

# difference as R - GRASS
r.mapcalc "diff = probability@r - probability@PERMANENT"
r.colors map=diff color=differences

# starting GUI in teh foreground pauses execution
# so even with --tmp-location and --exec the results can be explored
g.gui -f
