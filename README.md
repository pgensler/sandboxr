# sandboxr [![Build Status](https://travis-ci.org/pgensler/sandboxr.svg?branch=master)](https://travis-ci.org/pgensler/sandboxr)

Sandbox for testing out R packages in a reproducible way
Please download Docker and Docker Quickstart Terminal located here prior to using this image:


In order to use this container, simply do the following:
```docker pull pgensler/sandboxr``` which will download the container image to your machine.

Once you have pulled the image from docker hub, you can run the container using the following command to run the container:

```docker run -d -p 8787:8787 -v ~/Desktop:/home/rstudio pgensler/sandboxr```
This will map your ~/Desktop folder to the /home/rstudio folder so you can access files on your Desktop from inside the container

With Docker for Mac, you can now connect to the container via localhost:8787. See this for more details on Docker for Mac:
#for reference: http://blog.bennycornelissen.nl.s3-website-eu-west-1.amazonaws.com/post/docker-for-mac-neat-fast-and-flawed/

username: rstudio
password: rstudio

By default, docker is set to use 2gb of memory. If you wish to dedicate more resources to the machine,
Docker-> Preferences -> Advanced

Notes
RStudio uses port 8787 to connect on so you can only use that port with this container

Sample Dockerfiles 
If you are interested in what others sample dockerfiles look like, these are some that I continually go back and reference:

https://github.com/mhermans/dockerding/blob/master/rversioned/Dockerfile
http://www.hcbravo.org/IntroDataSci/homeworks/rocker/
https://hub.docker.com/r/andrewheiss/docker-example-r-environment/~/dockerfile/
https://github.com/verajosemanuel/tidyviz/blob/master/Dockerfile
