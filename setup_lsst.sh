#!/usr/bin/env bash

source /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib
echo "Setup LSST stack version:"
eups list -s | grep lsst_distrib
