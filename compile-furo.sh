#!/bin/bash

# compilation script for Furo - less automated than the other compile scripts.
# compilation done on a compute node, e.g. in interactive mode.
#
# pjsub --interact -L "node=1" -L "elapse=2:00:00" -L "rscgrp=fx-interactive" --mpi max-proc-per-node=48 --sparam wait-time=900


# Note: compiler is named mpifrt instead of mpifrtpx
# for now, change this manually in CMakelists.txt

export SYST=FX-Fujitsu
module load fftw/3.3.8
module load cmake/3.17.1
module load netcdf-fortran/4.5.2

cmake ../dales  -DUSE_FFTW=True
make -j 24 VERBOSE=1
