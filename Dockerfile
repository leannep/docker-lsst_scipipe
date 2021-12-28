# Default to w_latest if no tag is passed
ARG CENTOS_VER=7
ARG PRODUCT=lsst_distrib
ARG TAG=w_latest
ARG LSST_TAG=${CENTOS_VER}-stack-${PRODUCT}-${TAG}

FROM lsstsqre/centos:${LSST_TAG}

LABEL MAINTAINER="Leanne Guy <leanne@lsst.org>"
LABEL DESCRIPTION="Docker file for lsst-stack images"

ARG LSST_TAG
ARG LSST_USER=lsst
ARG HOME_DIR=/home/lsst
ARG BIN_DIR=${HOME_DIR}/bin
ENV LSST_TAG ${LSST_TAG}

# Setup the LSST environment
USER $LSST_USER
WORKDIR $HOME_DIR
RUN mkdir -p ${BIN_DIR}

WORKDIR $BIN_DIR
COPY ./source_lsst.sh .
COPY ./env_lsst.py .
RUN ["/bin/bash","-c", "./source_lsst.sh > source_lsst"]
RUN touch ${HOME_DIR}/.bashrc && \
    cat source_lsst >> ${HOME_DIR}/.bashrc  && \
    rm source_lsst
RUN python env_lsst.py --filename ${HOME_DIR}/lsst.env

WORKDIR $HOME_DIR