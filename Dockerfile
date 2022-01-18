# Default to w_latest if no tag is passed
ARG CENTOS_VER=7
ARG PRODUCT=lsst_distrib
ARG TAG=w_latest
ARG LSST_TAG=${CENTOS_VER}-stack-${PRODUCT}-${TAG}

FROM lsstsqre/centos:${LSST_TAG}

ARG LSST_TAG
LABEL MAINTAINER="Leanne Guy <leanne@lsst.org>"

USER lsst
WORKDIR /home/lsst

# TODO Maybe not needed - check for pycharm and docker-compose usage and remove if not
# COPY setup_lsst.sh /etc/profile.d/setup_lsst.sh

COPY --chown=lsst:lsst --chmod=755 setup_lsst.sh /home/lsst/setup_lsst.sh

# Update the user bashrc file to setup the LSST environment
RUN echo ". setup_lsst.sh" >>  /home/lsst/.bashrc && \
    cat /home/lsst/.bashrc

# Extract the lsst environment variables
# type -p python
COPY --chown=lsst:lsst --chmod=755 env_lsst.py /home/lsst/env_lsst.py
RUN $CONDA_PYTHON_EXE /home/lsst/env_lsst.py --filename /home/lsst/lsst.env

# Additional packages to install maybe
# pip install python-dotenv, mkinit

# Run a bash login shell as default
CMD ["/bin/bash", "-l"]