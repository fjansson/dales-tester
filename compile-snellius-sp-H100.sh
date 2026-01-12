#!/bin/bash

TAG=$1

export SYST=NV-OpenACC-H100

module load 2025
module load nvompi/2025.10
module load CMake/3.31.3-GCCcore-14.2.0
# locally installed :
module load netCDF/4.9.3-nvompi-2025.10
module load netCDF-Fortran/4.6.2-nvompi-2025.10




BUILD=build-$TAG-sp-$SYST

cd dales
git fetch
git checkout $TAG
cd ..
mkdir $BUILD
cd $BUILD

export FC=nvfortran
export CC=nvc
cmake ../dales  -DENABLE_FP32_FIELDS=ON -DENABLE_FP32_POIS=ON -DENABLE_ACC=ON

make -j 4 VERBOSE=1 


