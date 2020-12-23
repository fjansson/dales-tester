#!/bin/bash

TAG=$1


. /vol0001/apps/oss/spack/share/spack/setup-env.sh
spack load netcdf-fortran%fj
spack load cmake@3.17.3 arch=linux-rhel7-haswell


# version 4.2.1 and below don't find netcdf on Cartesius
# export NETCDF_INCLUDE=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/netCDF-Fortran/4.4.4-foss-2018b/include
# export NETCDF_LIB=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/netCDF-Fortran/4.4.4-foss-2018b/lib

# Uses -DUSE_HYPRE=True and -DUSE_FFTW=True
# versions before 4.3 do not support these, and will ignore them

# Versions before 4.2 do not recognize SYST=gnu-fast




export SYST=FX-Fujitsu
export LDFLAGS="-lhdf5_hl -lhdf5"


cd dales
git fetch
git checkout $TAG
cd ..
mkdir build-$TAG-$SYST
cd build-$TAG-$SYST

cmake ../dales -DUSE_FFTW=True

# other flags:
# -DFFTW_LIB=      not needed, found automatically
# -DUSE_HYPRE=True
# -DHYPRE_LIB=



make -j 4


