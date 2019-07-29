# Compare results from PoPS GRASS GIS module and R package

Please not that not everything is fully automated or well organized.

## Run R part natively

In command line:

```
Rscript run_r_pops_slf_simple.R
```

The other R scripts have currently some hardcoded paths which work only
in Docker and need to be adjusted for a native run. (This should be
fixed in the future.)

## Run R part in Docker (step 1)

```
docker build -t rpopstests .
docker run -v /your/local/dir:/outputs -it rpopstests
```

## Run GRASS GIS part and comparison locally (step 2)

The comparison script can be executed, e.g., using:

```
grass --tmp-location XY --exec ./run_comparison_pops_t10x10.sh
```

The script also executes the GRASS GIS part.

## Install the GRASS GIS module

The latest version of the module is in a separate Git repository
(unknown to GRASS GIS) and it contains submodules, so we need to
do the download part of the process manually using Git.

```
url="https://github.com/ncsu-landscape-dynamics/r.pops.spread"
git clone --recursive $url
grass --tmp-location XY --exec g.extension r.pops.spread url=r.pops.spread
```

### Case studies

1. Spotter lantern fly: See `run_r_pops_slf_simple.R` for a
   work-in-progress script which should be replaced by
   `run_r_pops_slf.R`.

## Data

A `data` directory needs to be placed in the current directory (whatever
is the current directory for the R, GRASS GIS, or Docker execution).

The expected content of the `data` directory is:

```
data/
├── slf
│   ├── avg_spread_crit_temp_slf_2018_2022_pm.tif
│   ├── avg_spread_temp_coefficient_slf_2018_2022_pm.tif
│   ├── initial_infections_2018_single_count_pm_prop.tif
│   ├── total_hosts.tif
│   └── tree_of_heaven_0.50.tif
├── t100x100
│   ├── all_plants.tif
│   ├── host.tif
│   ├── initial_infections_multi.tif
│   ├── initial_infections_single.tif
│   ├── temp_all.tif
│   ├── temp_none.tif
│   ├── temp_some.tif
│   ├── weather_0dot25.tif
│   ├── weather_0dot25.tif.aux.xml
│   ├── weather_0dot50.tif
│   ├── weather_0dot50.tif.aux.xml
│   ├── weather_0dot75.tif
│   ├── weather_0dot75.tif.aux.xml
│   ├── weather_0.tif
│   ├── weather_0.tif.aux.xml
│   ├── weather_1.tif
│   ├── weather_1.tif.aux.xml
│   ├── weather.tif
│   └── weather.tif.aux.xml
└── t10x10
    ├── ...
```

## Code

* The native run will use whatever you have installed.
* The Docker for R installs the latests version.
* A custom wrapper around PoPS package is in `pops_multiple.R`.
* Docker for GRASS GIS is missing.
