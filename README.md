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
be associated and the configuration and setup is automated. 

An list of all available tage can be found at
https://hub.docker.com/r/lsstsqre/centos/tags


Usage
-----

- Build the image from the Dockerfile. Defaults to the latest weekly tag if no tag is passed.
* docker build -t lsst-stack . 

    To specify a TAG explicitly, e.g a given daily, weekly or release,  
    * docker build -t leanne/lsst . --build-arg TAG=d_latest
    Example options for TAG are: 
      * specific weekly: w_2021_14,
      * specific daily: d_2021_07_14
      * specific release (22.0.1): v22_0_1, v_23_0_0
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

Setup apackage 
> file:///Users/leanne/LSST/pycharm-workspace/faro/doc/_build/html/lsst.faro/using.html#lsst-faro-setting-up
> 

Check that you are running the correct version of the stack 
* > source /software/lsstsw/stack/loadLSST.bash (done in docker)
* > setup lsst_distrib
* > eups list -s | grep lsst_distrib
* > eups list -s | grep faro

To setup a local package 
* > cd /mnt/repos/<package>
* > setup -k -r .
* > echo $FARO_DIR
  

To setup local datasets for testing (https://pipelines.lsst.
io/v/daily/getting-started/data-setup.html#downloading-the-sample-hsc-data)
* > cd /mnt/datasets/<dataset>
* > setup -j -r .
* > echo $RC2_SUBSET_DIR

LSST Science Pipelines tags
---------------------------

Tags are formatted as: 
  * --build-arg LSST_TAG=7-stack-lsst_distrib-d_2021_05_07  # * Daily from 2021-05-07
  * --build-arg LSST_TAG=d_latest  # Current daily
  * --build-arg LSST_TAG=w_latest   # Current Weekly
  * --build-arg LSST_TAG=7-stack-lsst_distrib-w_2021_17  # Weekly 17
  
Check the version of the stack 
------------------------------

Remove Docker containers
------------------------
* > docker ps : List all containers, running and stopped 
* > docker CONTAINER_ID : Stop the container with given ID
* > docker stop CONTAINER_ID | xargs docker rm
* > docker rm -f 
* > docker rm -f $(docker ps -a -q) : Remove all containers quietly
* > docker rmi $(docker images -q) : Remove all images quietly