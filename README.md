Tools for running the Rubin Science Pipelines with Docker
==========================================================

For a guide to using the Rubin LSST software stack, see:

http://pipelines.lsst.io

Description
------------

LSST provides versioned Docker images containing the Science Pipelines software. 
For a guide to running the Rubin Science Pipelines with Docker, see: 

https://pipelines.lsst.io/install/docker.html

A Docker file defines a single container. With docker-compose, multiple associated containers can 
be associated. Also the configuration can be automated

Usage
-----

A typical usage:

Defaults to w_latest if no LSST_TAG is passed
* docker build -t leanne/lsst-stack . --build-arg LSST_TAG=d_latest


* Start the project 
    * docker-compose up -d 
    * docker ps
* Show a list of containers for a service 
    * docker-compose ps 
* docker exec -it lsst-stack /bin/bash
* docker attach lsst-stack
* docker-compose down
