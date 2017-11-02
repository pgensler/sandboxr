# sandboxr [![Build Status](https://travis-ci.org/pgensler/sandboxr.svg?branch=master)](https://travis-ci.org/pgensler/sandboxr) [![Docker Build Status](https://img.shields.io/docker/build/pgensler/sandboxr.svg)]()

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

---------
#steps to run
1. Run Docker 4 mac
2. Run the following
```docker run --rm -p 8787:8787 pgensler/sandboxr:latest```
3. Connect to localhost:8787
4. Works!!
----------
this also works...need to run on localhost:8787
```docker run -d -p 8787:8787 -v ~/Desktop:/home/rstudio pgensler/sandboxr```
On ports, we are binding port 8787 on the host(before :) to 8787 on the container.
Same goes for making my local machine's file paths available to the container as above.

### Sample Dockerfiles 
If you are interested in what others sample dockerfiles look like, these are some that I continually go back and reference:

https://github.com/mhermans/dockerding/blob/master/rversioned/Dockerfile
http://www.hcbravo.org/IntroDataSci/homeworks/rocker/
https://hub.docker.com/r/andrewheiss/docker-example-r-environment/~/dockerfile/
https://github.com/verajosemanuel/tidyviz/blob/master/Dockerfile

### Travis Reference:
In order for the build to succeed, the .travis.yml file needs to have a script phase to test the container if it works.
Also, sample travis file, which was incredibly helpfull
A job fails if the return code of the script phase is non zero
https://docs.travis-ci.com/user/for-beginners/
http://bencane.com/2016/01/11/using-travis-ci-to-test-docker-builds/

### GitLabs
Using GitLabs locally on the command line:
http://docs.gitlab.com/ce/user/project/container_registry.html#using-with-private-projects

Build docker container on GitLabs, and publish to GitLabs for CI
https://github.com/docker/hub-feedback/issues/334

### Testing container locally:
https://www.sitepoint.com/how-to-build-an-image-with-the-dockerfile/


