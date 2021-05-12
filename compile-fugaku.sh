#!/bin/bash

TAG=$1


# before directory shuffle end of 2020
# obsolete 1. March 2021 when login nodes switching to RHEL 8
#. /vol0001/apps/oss/spack/share/spack/setup-env.sh
#spack load netcdf-fortran%fj
#spack load fftw@3.3.8%fj /4jakmbv
#spack load cmake@3.17.3 arch=linux-rhel7-haswell

# switch to older language environment,
# for Bus error reproduction test
#module unload lang
#module load lang/tcsds-1.2.29 

. /vol0004/apps/oss/spack/share/spack/setup-env.sh
spack load netcdf-fortran%fj
spack load fj-fftw
spack load cmake@3.18.4%gcc

# workaround for library errors in git after loading spack
# /usr/libexec/git-core/git-remote-https: symbol lookup error: /lib64/libk5crypto.so.3: undefined symbol: EVP_KDF_ctrl, version OPENSSL_1_1_1b
export LD_LIBRARY_PATH=/lib64:$LD_LIBRARY_PATH

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
mkdir build-$TAG-$SYST
cd build-$TAG-$SYST

cmake ../dales -DUSE_FFTW=True

# other flags:
# -DFFTW_LIB=      not needed, found automatically
# -DUSE_HYPRE=True
# -DHYPRE_LIB=

make -j 4


