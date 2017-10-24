##Combining this dockerfile:https://github.com/MethodsConsultants/tidyverse-h2o/blob/master/Dockerfile
##with this: https://hub.docker.com/r/andrewheiss/tidyverse-rstanarm/~/dockerfile/
FROM rocker/tidyverse:latest
LABEL maintainer="Peter Gensler <peterjgensler@gmail.com>"

# ------------------------------
# Install rstanarm and friends
# ------------------------------
# Docker Hub (and Docker in general) chokes on memory issues when compiling
# with gcc, so copy custom CXX settings to /root/.R/Makevars and use ccache and
# clang++ instead

# prophet needs rstan pkg, and we need to set Makevars compiler flag to compile properly


# Make ~/.R
RUN mkdir -p $HOME/.R

# $HOME doesn't exist in the COPY shell, so be explicit
COPY R/Makevars /root/.R/Makevars

# Install ggplot extensions like ggstance and ggrepel
# rm rf for removing all temp files after install
RUN apt-get update -qq \
    && apt-get -y --no-install-recommends install \
    liblzma-dev \
    libbz2-dev \
    clang  \
    ccache \
    default-jdk \
    default-jre \
    && R CMD javareconf \
    && install2.r --error \
        ggstance ggrepel ggthemes \
        ###My packag are below this line
        tidytext janitor corrr officer devtools pacman \
        tidyquant timetk tibbletime sweep broom prophet \
        forecast prophet lime sparklyr rsparkling \
        formattable httr rvest xml2 jsonlite \
        textclean naniar writexl \
    && Rscript -e 'devtools::install_github(c("hadley/multidplyr","jeremystan/tidyjson","ropenscilabs/skimr"))' \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
	&& rm -rf /var/lib/apt/lists/*