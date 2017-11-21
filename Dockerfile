##Combining this dockerfile:https://github.com/MethodsConsultants/tidyverse-h2o/blob/master/Dockerfile
##with this: https://hub.docker.com/r/andrewheiss/tidyverse-rstanarm/~/dockerfile/
#tidyverse image comes with devtools preinstalled
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
# adding devtools for starting and ending of package installation
# we need to use single quotes for packages:
# https://stackoverflow.com/questions/47127594/multi-line-rscript-in-dockerfile/47128124?noredirect=1#comment81206386_47128124


#linuxbrew packages below curl
RUN apt-get update -qq \
    && apt-get -y --no-install-recommends install \
    liblzma-dev \
    libbz2-dev \
    clang  \
    ccache \
    default-jdk \
    default-jre \
    libpoppler-cpp-dev \
    libapparmor-dev \
    xsel \
    xclip \
    && R CMD javareconf \
    && Rscript -e "devtools::install_cran(c('ggstance','ggrepel','ggthemes', \
           'tidytext','readtext','textclean','janitor','corrr','datapasta', \
           'tidyquant','timetk','tibbletime','sweep','broom','prophet', \
           'forecast','prophet','lime','sparklyr','h2o','rsparkling','unbalanced','yardstick', \
           'formattable','httr','rvest','xml2','jsonlite', \
           'corrr','officer','devtools','pacman','naniar','writexl'))" \
    ##GitHub Packages
    && Rscript -e 'devtools::install_github(c("hadley/multidplyr","jeremystan/tidyjson","ropenscilabs/skimr"))' \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
	&& rm -rf /var/lib/apt/lists/*
#FROM linuxbrew/linuxbrew
#COPY --from=linuxbrew /home/linuxbrew /home/linuxbrew
#ENV PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
#RUN brew config
