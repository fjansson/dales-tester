#!/bin/bash
#SBATCH -t 6:00:00
#SBATCH --ntasks-per-node=128
#SBATCH --partition=rome
#SBATCH --time=8:00:00
#SBATCH --ear=on
#SBATCH --ear-policy=monitoring
#SBATCH --ear-verbose=1


# note number of nodes to be specified when submitting


# Other useful SBATCH options

# #SBATCH -n 1152  #total number of tasks, number of nodes calculated automatically 
# #SBATCH -n 48  #number of nodes  



module load 2022
module load foss/2022a
module load netCDF-Fortran/4.6.0-gompi-2022a
module load CMake/3.23.1-GCCcore-11.3.0
module load Hypre/2.25.0-foss-2022a # optional



# submit as array job
# sbatch --array=1 -n 48  --export=TAG=4.2,NX=6,NY=8   dales-fftw-1152.job

# $SLURM_ARRAY_TASK_ID gives ID, which is used as random seed.
ID=$SLURM_ARRAY_TASK_ID


if [ -z "$TAG" ] 
then
    echo "Set variable TAG to the DALES version to run."
    exit
fi

if [ -z "$NX" ] 
then
    echo "Set variable NX to the number of tasks in x."
    exit
fi

if [ -z "$NY" ] 
then
    echo "Set variable NY to the number of tasks in y."
    exit
fi

NTOT=$(($NX*NY))

OPT=fftw
SYST=gnu-fast
NAMOPTIONS=namoptions-1728-fftw.001

DALES=`pwd`/../../build-$TAG-$SYST/src/dales4*

CASE=`pwd`
WORK=$SCRATCH/dales-tester/rico-$TAG-$SYST-$OPT-$NX-$NY/$ID

mkdir -p $WORK

cd $WORK
cp $CASE/{lscale.inp.001,$NAMOPTIONS,prof.inp.001,scalar.inp.001} ./

# edit random seed in namoptions
sed -i -r "s/irandom.*=.*/irandom = $ID/" $NAMOPTIONS

# edit nprocx, nprocy in namelist
sed -i -r "s/nprocx.*=.*/nprocx = $NX/;s/nprocy.*=.*/nprocy = $NY/" $NAMOPTIONS

echo ID $ID
echo SYST $SYST
echo DALES $DALES
echo CASE $CASE
echo WORK $WORK
echo hostname `hostname`
echo SLURM_NTASKS $SLURM_NTASKS
echo NTOT $NTOT
echo NX,NY $NX,$NY

srun -n $NTOT $DALES $NAMOPTIONS | tee output.txt

# it seems -n $NTOT must be spcified here, if -n is not included in the script
# but given on the command line??
# or number of tasks works better on cmdline than number of nodes?
