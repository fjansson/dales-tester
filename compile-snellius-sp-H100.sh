#!/bin/bash

TAG=$1

export SYST=NV-OpenACC-H100

module load 2023
module load foss/2023a
module load NVHPC/24.5-CUDA-12.1.1
module load CMake/3.26.3-GCCcore-12.3.0
module load netCDF/4.9.2-gompi-2023a

module load netCDF-Fortran/4.6.1-NVHPC-24.5-CUDA-12.1.1
# this one was locally installed

export NVHPC_HOME=${EBROOTNVHPC}/Linux_x86_64/2024
export LD_LIBRARY_PATH=${NVHPC_HOME}/math_libs/lib64:/${NVHPC_HOME}/cuda/lib64:$LD_LIBRARY_PATH
source $EBROOTNVHPC/Linux_x86_64/2024/comm_libs/12.4/hpcx/latest/hpcx-init.sh
hpcx_load
export OMPI_MCA_coll_hcoll_enable=0


BUILD=build-$TAG-sp-$SYST

cd dales
git fetch
git checkout $TAG
cd ..
mkdir $BUILD
cd $BUILD

FC=nvfortran cmake ../dales  -DENABLE_FP32_FIELDS=ON -DENABLE_FP32_POIS=ON -DENABLE_ACC=ON

make -j 4 VERBOSE=1 


