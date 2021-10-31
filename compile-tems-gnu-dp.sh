#!/bin/bash

# Compile script for DALES on ECMWF/TEMS
# using the GNU compiler.
# no HYPRE yet, no module for it
# Fredrik Jansson May 2021

TAG=$1

export SYST=gnu-fast
module load prgenv/gnu
# default gnu compiler version is 8.3
# module load gcc/10.2.0 # works
# module load gcc/10.3.0 # doesn't have fftw, netcdf?
module load gcc/11.1.0
module load openmpi
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
# replace modprecision.f90 with a double-precision version
cp ../modprecision-dp.f90 src/modprecision.f90
cd ..
mkdir build-$TAG-dp-$SYST
cd build-$TAG-dp-$SYST

cmake ../dales -DUSE_FFTW=True \
      -DFFTWF_LIB=$FFTW_DIR/lib/libfftw3f.a \
      -DFFTW_LIB=$FFTW_DIR/lib/libfftw3.a  -DFFTW_INCLUDE_DIR=$FFTW_DIR/include

make -j 4 | tee compilation-log.txt

# restore modprecision.f90
cd ..
cd dales
git checkout src/modprecision.f90

