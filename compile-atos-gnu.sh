#!/bin/bash

# Compile script for DALES on ECMWF/Atos system
# using the GNU compiler.
# no HYPRE yet, no module for it
# Fredrik Jansson July 2022

TAG=$1

export SYST=gnu-fast
module load prgenv/gnu
# default gnu compiler version is 8.3
module load gcc/11.2.0
module load openmpi
module load cmake/3.20.2
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

cmake ../dales -DUSE_FFTW=True \
      -DFFTWF_LIB=$FFTW_DIR/lib/libfftw3f.a \
      -DFFTW_LIB=$FFTW_DIR/lib/libfftw3.a  -DFFTW_INCLUDE_DIR=$FFTW_DIR/include

make -j 8 | tee compilation-log.txt


