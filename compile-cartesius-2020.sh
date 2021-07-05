#!/bin/bash

TAG=$1

export SYST=gnu-fast

# trying 2020 module set with gcc 9.3.0
module load 2020
module load netCDF-Fortran/4.5.2-gompi-2020a
module load CMake/3.16.4-GCCcore-9.3.0
module load Hypre/2.18.2-foss-2020a
module load FFTW/3.3.8-gompi-2020a


# version 4.2.1 and below don't find netcdf on Cartesius
export NETCDF_INCLUDE=/sw/arch/RedHatEnterpriseServer7/EB_production/2020/software/netCDF-Fortran/4.5.2-gompi-2020a/include
export NETCDF_LIB=/sw/arch/RedHatEnterpriseServer7/EB_production/2020/software/netCDF-Fortran/4.5.2-gompi-2020a/lib

# Uses -DUSE_HYPRE=True and -DUSE_FFTW=True
# versions before 4.3 do not support these, and will ignore them

# Versions before 4.2 do not recognize SYST=gnu-fast


cd dales
git fetch
git checkout $TAG
cd ..
mkdir build-$TAG-2020-$SYST
cd build-$TAG-2020-$SYST
                                            
cmake ../dales -DUSE_HYPRE=True \
-DHYPRE_LIB=/sw/arch/RedHatEnterpriseServer7/EB_production/2020/software/Hypre/2.18.2-foss-2020a/lib/libHYPRE.a \
-DUSE_FFTW=True -DFFTW_LIB=/sw/arch/RedHatEnterpriseServer7/EB_production/2020/software/FFTW/3.3.8-gompi-2020a/lib/libfftw3.a \
-DFFTW_INCLUDE_DIR=/sw/arch/RedHatEnterpriseServer7/EB_production/2020/software/FFTW/3.3.8-gompi-2020a/include

make -j 4 2>&1 | tee compilation-log.txt




