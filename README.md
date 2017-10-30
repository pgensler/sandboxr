# sandboxr [![Build Status](https://travis-ci.org/pgensler/sandboxr.svg?branch=master)](https://travis-ci.org/pgensler/sandboxr)

Sandbox for testing out R packages in a reproducible way
Please download Docker and Docker Quickstart Terminal located here prior to using this image:


In order to use this container, simply do the following:
```docker pull pgensler/sandboxr``` which will download the container image to your machine.

Once you have pulled the image from docker hub, you can run the container using the following command to run the container:

```docker run -d -p 8787:8787 -v ~/Desktop:/home/rstudio pgensler/sandboxr```
This will map your ~/Desktop folder to the /home/rstudio folder so you can access files on your Desktop from inside the container

Next, open up a web browser, and connect to the container via
<docker-machine ip>:8787
Your docker machine ip is the IP address that docker gives you when starting up Docker Quickstart Terminal.
If you do not know what this is, simply type in the terminal ```docker-machine ip```, and you should be all set.
You can login to the container using the following credentials:
username: rstudio
password: rstudio

By default, docker is set to use 2gb of memory. If you wish to dedicate more resources to the machine,
Docker-> Preferences -> Advanced

Notes
RStudio uses port 8787 to connect on so you can only use that port with this container
