#!/bin/bash

TAG=$1
# December 2021 update. frtpx (FRT) 4.7.0 20211110
. /vol0004/apps/oss/spack-v0.17.0/share/spack/setup-env.sh
spack load netcdf-fortran%fj/ayace7t
spack load fftw%fj  


# system-wide spack - after Sept 2021 update, environment version '4.6.1 tcsds-1.2.33'
# note uses spack-v0.16.2 path which is not officially documented (?)
#. /vol0004/apps/oss/spack-v0.16.2/share/spack/setup-env.sh
#spack load netcdf-fortran%fj /bubmb4i
#spack load fftw%fj

# local spack - used before Sept 2021
# Trying to work around mixing of 1.2.29 and 1.2.31 environments
# . ~/spack/share/spack/setup-env.sh
# spack load netcdf-fortran%fj
# spack load fftw%fj +openmp


# workaround for library errors in git after loading spack
# /usr/libexec/git-core/git-remote-https: symbol lookup error: /lib64/libk5crypto.so.3: undefined symbol: EVP_KDF_ctrl, version OPENSSL_1_1_1b
# export LD_LIBRARY_PATH=/lib64:$LD_LIBRARY_PATH

# DALES 4.3-rc.2 and earlier don't work on Fugaku.
# Support added in branches fugaku and to4.4_Fredrik
#
# Uses -DUSE_HYPRE=True and -DUSE_FFTW=True
# versions before 4.3 do not support these, and will ignore them

# Versions before 4.2 do not recognize SYST=gnu-fast


export SYST=FX-Fujitsu
export LDFLAGS="-lhdf5_hl -lhdf5"


cd dales
git fetch
git checkout $TAG
cd ..
mkdir build-$TAG-sp-$SYST
cd build-$TAG-sp-$SYST

cmake ../dales -DFIELD_PRECISION=32 -DPOIS_PRECISION=32 -DUSE_FFTW=True 

# other flags:
# -DFFTW_LIB=      not needed, found automatically
# -DUSE_HYPRE=True
# -DHYPRE_LIB=

make -j 4 2>&1 | tee compilation-log.txt



