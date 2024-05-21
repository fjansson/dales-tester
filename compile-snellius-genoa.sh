#!/bin/bash

TAG=$1

export SYST=gnu-fast

module load 2023
module load foss/2023a
module load netCDF-Fortran/4.6.1-gompi-2023a
module load CMake/3.26.3-GCCcore-12.3.0
module load Hypre/2.29.0-foss-2023a

# version 4.2.1 and below don't find netcdf on Cartesius
#export NETCDF_INCLUDE=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/netCDF-Fortran/4.4.4-foss-2018b/include
#export NETCDF_LIB=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/netCDF-Fortran/4.4.4-foss-2018b/lib

# Uses -DUSE_HYPRE=True and -DUSE_FFTW=True
# versions before 4.3 do not support these, and will ignore them

# Versions before 4.2 do not recognize SYST=gnu-fast

BUILD=build-$TAG-genoa-$SYST

cd dales
git fetch
git checkout $TAG
cd ..
mkdir $BUILD
cd $BUILD

cmake ../dales -DUSE_HYPRE=True -DUSE_FFTW=True 

make -j 4


