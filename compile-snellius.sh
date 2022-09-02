#!/bin/bash

TAG=$1

export SYST=gnu-fast

module load 2021
module load foss/2021a
# module load FFTW/3.3.9-gompi-2021a # included in foss
module load netCDF-Fortran/4.5.3-gompi-2021a
module load CMake/3.20.1-GCCcore-10.3.0
module load Hypre/2.21.0-foss-2021a # optional


# version 4.2.1 and below don't find netcdf on Cartesius
#export NETCDF_INCLUDE=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/netCDF-Fortran/4.4.4-foss-2018b/include
#export NETCDF_LIB=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/netCDF-Fortran/4.4.4-foss-2018b/lib

# Uses -DUSE_HYPRE=True and -DUSE_FFTW=True
# versions before 4.3 do not support these, and will ignore them

# Versions before 4.2 do not recognize SYST=gnu-fast


cd dales
git fetch
git checkout $TAG
cd ..
mkdir build-$TAG-$SYST
cd build-$TAG-$SYST

cmake ../dales -DUSE_HYPRE=True -DUSE_FFTW=True

# cartesius version:
# cmake ../dales -DUSE_HYPRE=True -DHYPRE_LIB=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/Hypre/2.14.0-foss-2018b/lib/libHYPRE.a -DUSE_FFTW=True -DFFTW_LIB=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/FFTW/3.3.8-gompi-2018b/lib/libfftw3.a -DFFTW_INCLUDE_DIR=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/FFTW/3.3.8-gompi-2018b/include

make -j 4


