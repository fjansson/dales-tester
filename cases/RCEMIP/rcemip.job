#!/bin/bash
#SBATCH -t 36:00:00
#SBATCH -n 24  #total number of tasks, number of nodes calculated automatically 
#SBATCH --constraint=haswell # Runs only on Haswell nodes (faster, AVX2)

# Other useful SBATCH options
# #SBATCH -N 2  #number of nodes 
# #SBATCH --ntasks-per-node=16
# #SBATCH --constraint=ivy # Runs only on Ivy Bridge nodes
# #SBATCH --constraint=haswell # Runs only on Haswell nodes (faster, AVX2)


# submit as array job   sbatch --array=1-5 --export=TAG=4.3-rc.1 rcemip.job 
# $SLURM_ARRAY_TASK_ID gives ID, which is used as random seed.
ID=$SLURM_ARRAY_TASK_ID

#TAG=4.3-rc.1
#TAG=4.2.1
#TAG=4.1

if [ -z "$TAG" ] 
then
      echo "Set variable $TAG to the DALES version to run."
      exit
fi

SYST=gnu-fast

NAMOPTIONS=namoptions.300

module load 2019
module load netCDF-Fortran/4.4.4-foss-2018b
module load CMake/3.12.1-GCCcore-7.3.0
module unload OpenMPI/3.1.1-GCC-7.3.0-2.30
module load OpenMPI/3.1.4-GCC-7.3.0-2.30
module load Hypre/2.14.0-foss-2018b
module load FFTW/3.3.8-gompi-2018b

DALES=`pwd`/../../build-$TAG-$SYST/src/dales4

PROJECT=/projects/0/einf170/
CASE=`pwd`
WORK=$PROJECT/janssonf/dales-tester/RCEMIP-$TAG-$SYST/$ID

mkdir -p $WORK
cd $WORK
cp $CASE/{lscale.inp.300,$NAMOPTIONS,prof.inp.300,scalar.inp.300,rrtmg*.nc,backrad*.nc} ./


# edit random seed in namoptions
sed -i -r "s/irandom.*=.*/irandom = $ID/" $NAMOPTIONS

echo ID $ID
echo SYST $SYST
echo DALES $DALES
echo CASE $CASE
echo WORK $WORK

time srun $DALES $NAMOPTIONS
