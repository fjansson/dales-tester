#!/bin/bash

TAG=$1

export SYST=gnu-fast

module load 2019
module load netCDF-Fortran/4.4.4-foss-2018b
module load CMake/3.12.1-GCCcore-7.3.0
module unload OpenMPI/3.1.1-GCC-7.3.0-2.30
module load OpenMPI/3.1.4-GCC-7.3.0-2.30
module load Hypre/2.14.0-foss-2018b
module load FFTW/3.3.8-gompi-2018b

# version 4.2.1 and below don't find netcdf on Cartesius
export NETCDF_INCLUDE=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/netCDF-Fortran/4.4.4-foss-2018b/include
export NETCDF_LIB=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/netCDF-Fortran/4.4.4-foss-2018b/lib

# Uses -DUSE_HYPRE=True and -DUSE_FFTW=True
# versions before 4.3 do not support these, and will ignore them

# Versions before 4.2 do not recognize SYST=gnu-fast


cd dales
git fetch
git checkout $TAG
cd ..
mkdir build-$TAG-$SYST
cd build-$TAG-$SYST

cmake ../dales -DUSE_HYPRE=True -DHYPRE_LIB=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/Hypre/2.14.0-foss-2018b/lib/libHYPRE.a -DUSE_FFTW=True -DFFTW_LIB=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/FFTW/3.3.8-gompi-2018b/lib/libfftw3.a -DFFTW_INCLUDE_DIR=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/FFTW/3.3.8-gompi-2018b/include

make -j 4


