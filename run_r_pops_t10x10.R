library(PoPS)
library(raster)

source("pops_multiple.R")

runs <- 100

data <- pops_multiple(
    infected_file="data/t10x10/initial_infections_single.tif",
    host_file="data/t10x10/host.tif",
    total_plants_file="data/t10x10/all_plants.tif",
    temperature_file="",
    temperature_coefficient_file="data/t10x10/weather_0dot50.tif",
    precipitation_coefficient_file="data/t10x10/weather_1.tif",
    use_lethal_temperature=FALSE,
    temp=TRUE,
    precip=TRUE,
    season_month_start=1,
    season_month_end=12,
    time_step="month",
    start_time=2019,
    end_time=2020,
    dispersal_kern="cauchy",
    percent_short_distance_dispersal=1.0,
    short_distance_scale=20.57,
    long_distance_scale=0.0,
    lethal_temperature=-13,
    lethal_temperature_month=1,
    wind_dir="NONE",
    kappa=0,
    random_seed=42,
    reproductive_rate=4.4,
    treatments_file="",
    treatment_years=c(0),
    management=FALSE,
    mortality_on=FALSE,
    mortality_rate=0,
    mortality_time_lag=0,
    #treatment_method="ratio",
    runs=runs
)

# last infected matrix from each
infected_series <- lapply(data, function(x) { x$infected[[length(x$infected)]] })

infected_series_TF <- lapply(infected_series, function(x) { x > 0 })

# TFs are added as 01s
probability <- Reduce(`+`, infected_series_TF) / runs

dir.create("/outputs/data/output_t10x10", recursive = TRUE)
writeRaster(raster(probability), "/outputs/data/output_t10x10/probability.tif", "GTiff", options=c('TFW=YES'), overwrite=TRUE)
