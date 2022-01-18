# https://itnext.io/docker-makefile-x-ops-sharing-infra-as-code-parts-ea6fa0d22946
PROJECT = docker-lsst_scipipe

# Note. If you change this, you also need to update docker-compose.yml
SERVICE := lsst

# The lsst_distrib tag to use
TAG ?= w_latest

# List of all containers
DOCKER_CONTAINER_LIST := $(shell docker ps -a -q)

# List of all images
DOCKER_IMAGE_LIST := $(shell docker images -q)

# List of all volumes
DOCKER_VOLUME_LIST := $(shell docker volume ls -q)

# all  targets are phony
.PHONY: build env-file up down shell prune clean clean-containers clean-images clean-volumes

all: service shell

service: build up

build:
	# Build the LSST image from the Docker file (--progress=plain)
	docker build --no-cache  -t leanne/lsst-stack  -f ./Dockerfile . --build-arg TAG=$(TAG)

run-shell:
	# Default CMD is for a login shell
	docker run -it leanne/lsst-stack

env-file:
	# copy the lsst.env file
	docker run --rm -v `pwd`:/app leanne/lsst-stack /bin/cp /home/lsst/lsst.env /app

up: env-file
	# run a detached container
	docker compose --env-file ./lsst.env up -d

shell:
	# connect to the container with a bash shell
	docker exec -it lsst /bin/bash -l

down:
	docker compose down

prune:
	# clean everything that is not actively used
	docker system prune -af

clean: clean-containers clean-images clean-volumes

clean-containers:
	# force stop and remove *all* containers
	@if [ -n "$(DOCKER_CONTAINER_LIST)" ]; \
    then \
    	echo "Removing docker containers" && \
    	 docker stop $(DOCKER_CONTAINER_LIST) && \
    	 docker rm $(DOCKER_CONTAINER_LIST); \
	else echo "No containers found"; \
 	fi;
clean-images:
	# force stop and remove *all* images
	@if [ -n "$(DOCKER_IMAGE_LIST)" ]; \
	then \
		echo "Removing docker images" && docker rmi --force $(DOCKER_IMAGE_LIST); \
	else echo "No images found"; \
	fi;
clean-volumes:
	# force stop and remove *all* volumes
	@if [ -n "$(DOCKER_VOLUME_LIST)" ]; \
	then \
		echo "Removing docker volumes" && docker volume rm  $(DOCKER_VOLUME_LIST); \
	else echo "No volumes found"; \
	fi;
