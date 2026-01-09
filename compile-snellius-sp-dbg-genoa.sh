#!/bin/bash

TAG=$1

# not used in DALES >= 5.0
export SYST=gnu-fast

module load 2025
module load foss/2025a
module load netCDF-Fortran/4.6.2-gompi-2025a
module load CMake/3.31.3-GCCcore-14.2.0
#module load Hypre/2.33.0-foss-2025a

# version 4.2.1 and below don't find netcdf on Cartesius
#export NETCDF_INCLUDE=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/netCDF-Fortran/4.4.4-foss-2018b/include
#export NETCDF_LIB=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/netCDF-Fortran/4.4.4-foss-2018b/lib

# Uses -DUSE_HYPRE=True and -DUSE_FFTW=True
# versions before 4.3 do not support these, and will ignore them

# Versions before 4.2 do not recognize SYST=gnu-fast

BUILD=build-$TAG-sp-dbg-genoa-$SYST

cd dales
git fetch
git checkout $TAG
cd ..
mkdir $BUILD
cd $BUILD

cmake ../dales -DCMAKE_BUILD_TYPE=Debug -DENABLE_FP32_FIELDS=ON -DENABLE_FP32_POIS=ON

make -j 4
