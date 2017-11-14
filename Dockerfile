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

##Linuxbrew
# Set up UTF-8
RUN apt-get update && \
    apt-get install -y apt-utils locales && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8

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
    build-essential \
    curl \
    file \
    git \
    build-essential \
    python-setuptools \
    && R CMD javareconf \
    && Rscript -e "devtools::install_cran(c('ggstance','ggrepel','ggthemes', \
           'tidytext','readtext','textclean','janitor','corrr','datapasta', \
           'tidyquant','timetk','tibbletime','sweep','broom','prophet', \
           'forecast','prophet','lime','sparklyr','h2o','rsparkling','unbalanced', \
           'formattable','httr','rvest','xml2','jsonlite', \
           'corrr','officer','devtools','pacman','naniar','writexl'))" \
    ##GitHub Packages
    && Rscript -e 'devtools::install_github(c("hadley/multidplyr","jeremystan/tidyjson","ropenscilabs/skimr"))' \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
	&& rm -rf /var/lib/apt/lists/*

# Create a linuxbrew user
RUN  useradd -m -s /bin/bash linuxbrew \
     && echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers
USER linuxbrew
WORKDIR /home/linuxbrew
ENV PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH \
    SHELL=/bin/bash

# Install Linuxbrew from github
RUN git clone https://github.com/Linuxbrew/brew.git .linuxbrew

# Install portable-ruby by running brew for the first time
RUN brew doctor
