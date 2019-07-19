# Compare results from PoPS GRASS GIS module and R package

Please not that not everything is fully automated or well organized.

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
