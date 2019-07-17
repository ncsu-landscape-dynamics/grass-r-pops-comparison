FROM r-base

RUN \
    apt-get update -y && apt-get upgrade -y && \
    apt-get install -y libxml2-dev libssl-dev libcurl4-gnutls-dev

RUN R -e "install.packages('devtools', repos = 'http://cran.us.r-project.org')"

RUN apt-get install -y libgdal-dev gdal-bin

RUN R -e "library(devtools); devtools::install_github('ncsu-landscape-dynamics/rpops')"

COPY . /usr/local/src/myscripts
WORKDIR /usr/local/src/myscripts

CMD ["Rscript", "run_pops_t10x10.R"]
