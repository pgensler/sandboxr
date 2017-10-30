#CHECK PACKAGE DEPEDENCIES
install.packages("miniCRAN")
install.packages("igraph")
library(igraph)
library(miniCRAN)


###My packag are below this line
##31 in total
#removing textclean from the mix
sandbox_pkgs <-c("ggstance","ggrepel","ggthemes","tidyverse","tidytext","janitor","corrr","officer","devtools","pacman",
           "tidyquant","timetk","tibbletime","sweep","broom","prophet",
           "forecast","prophet","lime","sparklyr","h2o","rsparkling","unbalanced",
           "formattable","httr","rvest","xml2","jsonlite",
           "naniar","writexl","tidyjson","multidplyr","skimr")
#Note: these pkgs have rJava as dep with install.packages as default
##textclean has rJava as dep??
##same as tidyquant?
##timetk has rJava
##sweep as well
depd <- pkgDep(sandbox_pkgs, depends = TRUE)
print(depd)


#cex function documentation
#http://rfunction.com/archives/2154
#plot results
#depends = TRUE means "Depends", "Imports", "LinkingTo"
dg <- makeDepGraph(sandbox_pkgs, depends =TRUE, availPkgs = cranJuly2014)
set.seed(1)
plot(dg, legendPosition =c(-1,-1), vertex.size=10, cex=.6)
