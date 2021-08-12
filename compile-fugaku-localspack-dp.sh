#!/bin/bash

TAG=$1

# system-wide spack
#. /vol0004/apps/oss/spack/share/spack/setup-env.sh
# spack load netcdf-fortran%fj
# spack load fj-fftw
# spack load cmake@3.18.4%gcc

# local spack
# Trying to work around mixing of 1.2.29 and 1.2.31 environments
. ~/spack/share/spack/setup-env.sh
spack load netcdf-fortran%fj
spack load fftw%fj +openmp


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

# replace modprecision.f90 with a double-precision version
cp ../modprecision-dp.f90 src/modprecision.f90
cd ..

mkdir build-$TAG-dp-$SYST
cd build-$TAG-dp-$SYST

cmake ../dales -DUSE_FFTW=True

# other flags:
# -DFFTW_LIB=      not needed, found automatically
# -DUSE_HYPRE=True
# -DHYPRE_LIB=

make -j 4 2>&1 | tee compilation-log.txt

# restore modprecision.f90
cd ..
cd dales
git checkout src/modprecision.f90
