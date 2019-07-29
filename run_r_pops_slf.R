library(PoPS)
library(raster)

source("pops_multiple.R")

runs <- 1

data <- pops_multiple(
    infected_file="data/slf/initial_infections_2018_single_count_pm_prop.tif",
    host_file="data/slf/tree_of_heaven_0.50.tif",
    total_plants_file="data/slf/total_hosts.tif",
    temperature_file="data/slf/avg_spread_crit_temp_slf_2018_2022_pm.tif",
    temperature_coefficient_file="data/slf/avg_spread_temp_coefficient_slf_2018_2022_pm.tif",
    precipitation_coefficient_file="",
    use_lethal_temperature=TRUE,
    temp=TRUE,
    precip=FALSE,
    season_month_start=5,
    season_month_end=11,
    time_step="month",
    start_time=2019,
    end_time=2021,
    dispersal_kern="cauchy",
    percent_short_distance_dispersal=1.0,
    short_distance_scale=47,
    long_distance_scale=0.0,
    lethal_temperature=-13,
    lethal_temperature_month=1,
    wind_dir="NONE",
    kappa=0,
    random_seed=42,
    reproductive_rate=2.1,
    treatments_file="",
    treatment_years=c(0),
    management=FALSE,
    mortality_on=FALSE,
    mortality_rate=0,
    mortality_time_lag=0,
    runs=runs
)

# last infected matrix from each
#infected_series <- lapply(data, function(x) { x$infected[[length(x$infected)]] })

#infected_series_TF <- lapply(infected_series, function(x) { x > 0 })

# TFs are added as 01s
#probability <- Reduce(`+`, infected_series_TF) / runs

#dir.create("/outputs/data/output_slf", recursive = TRUE)
#writeRaster(raster(probability), "/outputs/data/output_slf/probability.tif", "GTiff", options=c('TFW=YES'), overwrite=TRUE)
