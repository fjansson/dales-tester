#!/bin/bash

# Compile script for DALES on ECMWF/Atos system
# using the GNU compiler.
# Fredrik Jansson December 2025

TAG=$1

module load prgenv/expert
module load gcc/15.2.0
module load openmpi/4.1.7.1.7:gnu:15.2
module load netcdf4/4.9.3:gnu:15.2
module load netcdf4/4.9.3:gnu:15.2
module load cmake/4.0.2

# with gcc 14.2
#module load prgenv/expert
#module load gcc/14.2.0
#module load openmpi/4.1.7.1.7:gnu:14.2
#module load netcdf4/4.9.3:gnu:14.2
#module load netcdf4/4.9.3:gnu:14.2
#module load cmake/4.0.2

BUILD=build-$TAG-gnu-sp

# set FC, otherwise cmake picks system's f95
export FC=mpif90

cd dales
git fetch
git checkout $TAG
cd ..
mkdir $BUILD
cd $BUILD

cmake ../dales -DENABLE_FP32_FIELDS=ON -DENABLE_FP32_POIS=ON

make -j 8



