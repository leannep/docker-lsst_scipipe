# Default to w_latest if no tag is passed
ARG LSST_TAG=w_latest
FROM lsstsqre/centos:${LSST_TAG}
ARG LSST_TAG

LABEL maintainer="Leanne Guy <leanne@lsst.org>"

USER lsst
ENV LSST_TAG ${LSST_TAG}
COPY ./source_lsst.sh /etc/profile.d

WORKDIR /home/lsst
RUN mkdir -p /home/lsst/bin
COPY ./env_lsst.py /home/lsst/bin
COPY ./source_lsst.sh /home/lsst/bin

RUN python bin/env_lsst.py --filename lsst.env
