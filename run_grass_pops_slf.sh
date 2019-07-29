#!/bin/bash

set -e

infected_file="data/slf/initial_infections_2018_single_count_pm_prop.tif"
host_file="data/slf/tree_of_heaven_0.50.tif"
total_plants_file="data/slf/total_hosts.tif"
temperature_file="data/slf/avg_spread_crit_temp_slf_2018_2022_pm.tif"
temperature_coefficient_file="data/slf/avg_spread_temp_coefficient_slf_2018_2022_pm.tif"

r.import $host_file output=host --q
r.import $total_plants_file output=all_plants --q
r.import $infected_file output=initial_infections --q
r.import $temperature_file output=temperature --q
r.import $temperature_coefficient_file output=temperature_coefficient --q
#r.import "data/t100x100/weather_1.tif" output=weather_1 --q

r.null host null=0
r.null all_plants null=0
r.null initial_infections null=0

g.list type=raster pattern="temperature_coefficient.*" mapset=. | sort -k2 -t. -n > "data/slf/temperature_coefficient.txt"
g.list type=raster pattern="temperature.*" mapset=. | sort -k2 -t. -n > "data/slf/temperature.txt"

g.region raster=host

r.mapcalc "const_1 = 1"
NUM_LINES=`cat "data/slf/temperature_coefficient.txt" | wc -l`
echo const_1 > "data/slf/coefficient_1.txt"
for LINE in `seq 2 $NUM_LINES`
do
    echo const_1 >> "data/slf/coefficient_1.txt"
done

r.pops.spread \
    host=host \
    total_plants=all_plants \
    infected=initial_infections \
    temperature_coefficient_file="data/slf/temperature_coefficient.txt" \
    moisture_coefficient_file="data/slf/coefficient_1.txt" \
    step="month" \
    start_time=2019 \
    end_time=2021 \
    seasonality=5,11 \
    dispersal_kernel="cauchy" \
    percent_short_dispersal=1.0 \
    short_distance_scale=47 \
    wind="NONE" \
    kappa=0 \
    random_seed=42 \
    reproductive_rate=2.1 \
    temperature_file="data/t100x100/temperature.txt" \
    lethal_temperature=-13 \
    lethal_month=1 \
    output_series=output \
    probability=probability \
    runs=100 \
    nprocs=4
