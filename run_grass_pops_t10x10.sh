#!/bin/bash

url="https://github.com/ncsu-landscape-dynamics/r.pops.spread"

# we expect this to be already done
# git clone --recursive $url
# g.extension r.pops.spread url=r.pops.spread

r.import "data/t10x10/host.tif" output=host --q
r.import "data/t10x10/all_plants.tif" output=all_plants --q
r.import "data/t10x10/initial_infections_single.tif" output=initial_infections_single --q
r.import "data/t10x10/weather_0dot50.tif" output=weather_0dot50 --q
r.import "data/t10x10/weather_1.tif" output=weather_1 --q

g.list type=raster pattern="weather_0dot50.*" mapset=. | sort -k2 -t. -n > "data/t10x10/weather_0dot50.txt"
g.list type=raster pattern="weather_1.*" mapset=. | sort -k2 -t. -n > "data/t10x10/weather_1.txt"
#g.list type=raster pattern="temp_some.*" mapset=. | sort -k2 -t. -n > "data/t10x10/temp_some.txt"

g.region raster=host

r.pops.spread \
    host=host \
    total_plants=all_plants \
    infected=initial_infections_single \
    temperature_coefficient_file="data/t10x10/weather_0dot50.txt" \
    moisture_coefficient_file="data/t10x10/weather_1.txt" \
    step="month" \
    start_time=2019 \
    end_time=2020 \
    dispersal_kernel="cauchy" \
    percent_short_dispersal=1.0 \
    short_distance_scale=20.57 \
    wind="NONE" \
    random_seed=42 \
    reproductive_rate=4.4 \
    output_series=output \
    probability=probability \
    runs=100 \
    nprocs=4
