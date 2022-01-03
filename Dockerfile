# Default to w_latest if no tag is passed
ARG CENTOS_VER=7
ARG PRODUCT=lsst_distrib
ARG TAG=w_latest
ARG LSST_TAG=${CENTOS_VER}-stack-${PRODUCT}-${TAG}

FROM lsstsqre/centos:${LSST_TAG}

LABEL MAINTAINER="Leanne Guy <leanne@lsst.org>"
LABEL DESCRIPTION="Docker file to pull and setup lsst-stack images"

ARG LSST_TAG
ENV LSST_TAG ${LSST_TAG}
ARG LSST_USER=lsst
ARG HOME_DIR=/home/lsst
ARG BIN_DIR=${HOME_DIR}/bin
USER $LSST_USER

# Setup the LSST environment
COPY source_lsst.sh /etc/profile.d
WORKDIR $HOME_DIR
RUN mkdir -p $BIN_DIR
COPY ./env_lsst.py $BIN_DIR
COPY ./setup_lsst.sh $BIN_DIR

# Update .bashrc to activate the lsst environment on login (maybe not needed with /etc/profile.d above)
RUN ["/bin/bash","-c", "/home/lsst/bin/setup_lsst.sh >>  /home/lsst/.bashrc"]
RUN chmod 755 /home/lsst/.bashrc

# Extract the LSST env variables
RUN python bin/env_lsst.py --filename $HOME_DIR/lsst.env