#!/bin/bash

# Compile script for DALES on ECMWF/TEMS
# using the Intel compiler.
# no HYPRE yet, no module for it
# Fredrik Jansson May 2021

TAG=$1

export SYST=lisa-intel
module load prgenv/intel
module load intel-mpi
module load cmake/3.19.5
module load netcdf4/4.7.4
module load fftw/3.3.9

# TODO: FFTW paths - set environment variables or change CMakeLists.txt

# version 4.2.1 and below don't find netcdf on Cartesius
# export NETCDF_INCLUDE=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/netCDF-Fortran/4.4.4-foss-2018b/include
# export NETCDF_LIB=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/netCDF-Fortran/4.4.4-foss-2018b/lib

# Uses -DUSE_FFTW=True
# versions before 4.3 do not support these, and will ignore them

# Versions before 4.2 do not recognize SYST=gnu-fast


cd dales
git fetch
git checkout $TAG
cd ..
mkdir build-$TAG-$SYST
cd build-$TAG-$SYST

cmake ../dales -DUSE_FFTW=True 

make -j 4


