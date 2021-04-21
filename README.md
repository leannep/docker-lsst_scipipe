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

- Build the image from the Dockerfile.

    Default to the latest weekly tag if no tag is passed. 
    * docker build -t leanne/lsst . 

     Or specify a TAG explicitly, e.g 7-stack-lsst_distrib-w_2021_14, d_latest, w_latest
    * docker build -t leanne/lsst . --build-arg LSST_TAG=d_latest


Start the starts the container in the background (detached mode) and leave running. 
* docker-compose up -d 
    
Connect to the running container with a bash shell
* docker exec -it lsst /bin/bash -l

Stop and remove the containers, networks, volumes, and images, etc
* docker-compose down

Check that you are running the correct version of the stack 
* > eups list -s | grep lsst_distrib
* > eups list -s | grep faro