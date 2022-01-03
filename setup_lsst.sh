#!/bin/bash
now=`date +%Y-%m-%d-at-%H:%M:%S`
echo "# LSST stack Docker addition on ${now} adding commands to set up the LSST stack environment"
# Load the minimal LSST environment
echo ". /opt/lsst/software/stack/loadLSST.bash"
echo "setup lsst_distrib"
echo "## Finished adapting environment for the LSST stack"
