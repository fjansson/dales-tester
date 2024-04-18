#!/bin/bash

TAG=$1

# 2024 April
. /vol0004/apps/oss/spack/share/spack/setup-env.sh
spack load netcdf-fortran@4.6.0%fj/mmdtg52
spack load fftw%fj
spack load cmake@3.24.3%gcc/wyds2me  # load cmake to avoid the fj cmake loaded by spack

# export LD_LIBRARY_PATH=/lib64:$LD_LIBRARY_PATH

# DALES 4.3-rc.2 and earlier don't work on Fugaku.
# Support added in branches fugaku and to4.4_Fredrik
#
# Uses -DUSE_HYPRE=True and -DUSE_FFTW=True
# versions before 4.3 do not support these, and will ignore them

# Versions before 4.2 do not recognize SYST=gnu-fast


export SYST=FX-Fujitsu
export LDFLAGS="-lhdf5_hl -lhdf5" # for netcdf to find hdf5 libraries

cd dales
git fetch
git checkout $TAG
cd ..
mkdir build-$TAG-$SYST
cd build-$TAG-$SYST

cmake ../dales -DUSE_FFTW=True

# other flags:
# -DFFTW_LIB=      not needed, found automatically
# -DUSE_HYPRE=True
# -DHYPRE_LIB=

make -j 4 2>&1 | tee compilation-log.txt
