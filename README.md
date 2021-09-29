Tools for running the Rubin Science Pipelines with Docker
==========================================================

For a guide to using the Rubin LSST software stack, see:

http://pipelines.lsst.io

Description
------------

LSST provides versioned Docker images containing the Science Pipelines software. 
For a guide to running the Rubin Science Pipelines with Docker, see: 

https://pipelines.lsst.io/install/docker.html

The Docker file defines a single container to run. With docker-compose multiple associated containers can 
be associated and the configuration and setup is automated

Usage
-----

- Build the image from the Dockerfile. Defaults to the latest weekly tag if no tag is passed.
* docker build -t leanne/lsst . 

    To specify a TAG explicitly, e.g a given daily, weekly or release,  
    * docker build -t leanne/lsst . --build-arg LSST_TAG=d_latest
    Example options for LSST_TAG are: 
      * specific weekly: 7-stack-lsst_distrib-w_2021_14,
      * specific daily: 7-stack-lsst_distrib-d_2021_07_14
      * specific release (22.0.1): 7-stack-lsst_distrib-v22_0_1 
      * latest builds: d_latest, w_latest
    A full list of all available tags can be found at:
      * https://github.com/lsst/lsst_distrib/tags
  
Start the starts the container in the background (detached mode) and leave running. 
* docker compose up -d 
    
Execute an interactive bash shell on the running container. -t (-tty) -i (--interactive). 
-l makes bash act as if it had been invoked as a login shell
* docker exec -it lsst /bin/bash -l

Stop and remove the containers, networks, volumes, and images, etc
* docker compose down

Check that you are running the correct version of the stack 
* > eups list -s | grep lsst_distrib
* > eups list -s | grep faro

To setup a local package 
* > cd /mnt/repos/<package>
* > setup -k -r .
  

LSST Science Pipelines tags
---------------------------

Tags are formatted as: 
  * --build-arg LSST_TAG=7-stack-lsst_distrib-d_2021_05_07  # * Daily from 2021-05-07
  * --build-arg LSST_TAG=d_latest  # Current daily
  * --build-arg LSST_TAG=w_latest   # Current Weekly
  * --build-arg LSST_TAG=7-stack-lsst_distrib-w_2021_17  # Weekly 17
  