#!/bin/bash
#SBATCH --qos=np     # nf fractional queue  np parallel queue    np for > 1/2 node
#SBATCH -t 24:00:00
#SBATCH -n 512        #total number of tasks, number of nodes calculated automatically 
#SBATCH -A spnlsieb
#SBATCH --ntasks-per-node=128        

# Other useful SBATCH options
# # SBATCH -N 2  #number of nodes 
# # SBATCH --ntasks-per-node=16
# # SBATCH --mem-per-cpu=1G

# submit as array job  sbatch --array=1-5 --export=TAG=4.3-rc.1 rico-atos.job
# submit as array job  sbatch -n $(( NX*NY )) --export=TAG=139c4,NX,NY rico-atos.job

# $SLURM_ARRAY_TASK_ID gives ID, which is used as random seed.
# ID=$SLURM_ARRAY_TASK_ID
# for now take ID exported variables on submission command line instead   

#TAG=4.3-rc.1
#TAG=4.2.1
#TAG=4.1

if [ -z "$TAG" ] 
then
      echo "Set variable $TAG to the DALES version to run."
      exit
fi

if [ -z "$ID" ]
then
    ID=1
fi

if [ -z "$NX" ]
then
    NX=16
    echo "NX set to $NX"
fi

if [ -z "$NY" ]
then
    NY=32
    echo "NY set to $NY"
fi

NTOT=$((NX*NY))
SYST=gnu-fast
NAMOPTIONS=namoptions-1536.001

module load prgenv/gnu
module load gcc/11.2.0
module load openmpi
module load cmake/3.20.2
module load netcdf4/4.7.4
module load fftw/3.3.9


DALES=`pwd`/../../build-$TAG-$SYST/src/dales4*

CASE=`pwd`
WORK=$SCRATCH/dales-tester/botany7-$TAG-$SYST-$OPT-$NX-$NY/$ID

# map ID > 100 to negative numbers for RNG testing
# done *after assigning $WORK to avoid -1 as directory name which is very annoying
if [ $ID -ge 100 ]; then
    ID=$(( 100-ID ))
fi


mkdir -p $WORK
cd $WORK
cp $CASE/{lscale.inp.001,$NAMOPTIONS,prof.inp.001,scalar.inp.001,nudge.inp.001,rrtmg*nc,backrad*} ./

#create run directories                                                                                    # for i in `seq -f "%03.0f" 0 $((NY - 1))`; do mkdir $i; done
# not needed if no output

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

# /usr/bin/time -f"%e" 
srun $DALES $NAMOPTIONS | tee output.txt

