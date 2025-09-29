#!/bin/bash

TAG=$1

export SYST=NV-OpenACC-H100

module load 2024
module load foss/2024a
module load NVHPC/24.9-CUDA-12.6.0
module load CMake/3.29.3-GCCcore-13.3.0
module load netCDF/4.9.2-gompi-2024a

module load netCDF-Fortran/4.6.1-NVHPC-24.9-CUDA-12.6.0
# locally installed

export NVHPC_HOME=${EBROOTNVHPC}/Linux_x86_64/2024
export LD_LIBRARY_PATH=${NVHPC_HOME}/math_libs/12.6/lib64:/${NVHPC_HOME}/cuda/12.6/lib64:$LD_LIBRARY_PATH
source $EBROOTNVHPC/Linux_x86_64/2024/comm_libs/12.6/hpcx/latest/hpcx-init.sh
hpcx_load
export OMPI_MCA_coll_hcoll_enable=0


BUILD=build-$TAG-sp-$SYST

cd dales
git fetch
git checkout $TAG
cd ..
mkdir $BUILD
cd $BUILD

FC=mpif90 cmake ../dales  -DENABLE_FP32_FIELDS=ON -DENABLE_FP32_POIS=ON -DENABLE_ACC=ON

make -j 4 VERBOSE=1 


