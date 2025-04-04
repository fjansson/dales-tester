#!/bin/bash

TAG=$1

# 2024 April
# spack v0.21 and the matching tcsds-1.2.38 compiler
module unload lang
module load lang/tcsds-1.2.38
. /vol0004/apps/oss/spack-v0.21/share/spack/setup-env.sh
spack load netcdf-fortran@4.6.1%fj
spack load fftw%fj/tvu5j7p
spack load cmake@3.27.7%gcc@13.2.0/ylpx52y

export LDFLAGS="-lhdf5_hl -lhdf5"
export DIR=build-$TAG-mix-dbg

cd dales
git fetch
git checkout $TAG
cd ..
mkdir $DIR
cd $DIR

FC=mpifrtpx CC=mpifccpx cmake ../dales -DENABLE_FP32_FIELDS=ON -DCMAKE_BUILD_TYPE=Debug

make -j 4 2>&1 | tee compilation-log.txt
