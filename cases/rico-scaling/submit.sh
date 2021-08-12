#!/bin/bash

# Cartesius
# # baseline 4.2 branch
# sbatch --array=1 -n 48  --export=TAG=4.2,NX=6,NY=8   dales-fftw-1152.job
# sbatch --array=1 -n 72  --export=TAG=4.2,NX=6,NY=12  dales-fftw-1152.job
# sbatch --array=1 -n 144 --export=TAG=4.2,NX=12,NY=12 dales-fftw-1152.job
# sbatch --array=1 -n 288 --export=TAG=4.2,NX=24,NY=12 dales-fftw-1152.job
# sbatch --array=1 -n 576 --export=TAG=4.2,NX=24,NY=24 dales-fftw-1152.job

# # to4.3_Fredrik_micro
# sbatch --array=1 -n 48  --export=TAG=9d83a,NX=6,NY=8   dales-fftw-1152.job
# sbatch --array=1 -n 72  --export=TAG=9d83a,NX=6,NY=12  dales-fftw-1152.job
# sbatch --array=1 -n 144 --export=TAG=9d83a,NX=12,NY=12 dales-fftw-1152.job
# sbatch --array=1 -n 288 --export=TAG=9d83a,NX=24,NY=12 dales-fftw-1152.job
# sbatch --array=1 -n 576 --export=TAG=9d83a,NX=24,NY=24 dales-fftw-1152.job


# Fugaku  1728*672
# new, SP
# pjsub -x "TAG=3959f,NX=8,NY=24,ID=1"  -L "node=4"  dales-fftw-fugaku.job
# pjsub -x "TAG=3959f,NX=12,NY=16,ID=1"  -L "node=4"  dales-fftw-fugaku.job
# pjsub -x "TAG=3959f,NX=12,NY=24,ID=1"  -L "node=6"  dales-fftw-fugaku.job
# pjsub -x "TAG=3959f,NX=16,NY=24,ID=1"  -L "node=8"  dales-fftw-fugaku.job
# pjsub -x "TAG=3959f,NX=24,NY=16,ID=1"  -L "node=8"  dales-fftw-fugaku.job
# pjsub -x "TAG=3959f,NX=24,NY=24,ID=2"  -L "node=12"  dales-fftw-fugaku.job
# pjsub -x "TAG=3959f,NX=24,NY=48,ID=1"  -L "node=24"  dales-fftw-fugaku.job
# pjsub -x "TAG=3959f,NX=48,NY=48,ID=1"  -L "node=48"  dales-fftw-fugaku.job

# new,DP
pjsub -x "TAG=3959f-dp,NX=8,NY=24,ID=1"  -L "node=4"  dales-fftw-fugaku.job
pjsub -x "TAG=3959f-dp,NX=12,NY=16,ID=1"  -L "node=4"  dales-fftw-fugaku.job
pjsub -x "TAG=3959f-dp,NX=12,NY=24,ID=1"  -L "node=6"  dales-fftw-fugaku.job
pjsub -x "TAG=3959f-dp,NX=16,NY=24,ID=1"  -L "node=8"  dales-fftw-fugaku.job
pjsub -x "TAG=3959f-dp,NX=24,NY=16,ID=1"  -L "node=8"  dales-fftw-fugaku.job
pjsub -x "TAG=3959f-dp,NX=24,NY=24,ID=2"  -L "node=12"  dales-fftw-fugaku.job
pjsub -x "TAG=3959f-dp,NX=24,NY=48,ID=1"  -L "node=24"  dales-fftw-fugaku.job
pjsub -x "TAG=3959f-dp,NX=48,NY=48,ID=1"  -L "node=48"  dales-fftw-fugaku.job


# # same version as benchmarked on FURO
# #pjsub -x "TAG=b7d9d,NX=8,NY=24,ID=1"  -L "node=4"  dales-fftw-fugaku.job    OOM
# #pjsub -x "TAG=b7d9d,NX=12,NY=16,ID=1"  -L "node=4"  dales-fftw-fugaku.job   OOM
# pjsub -x "TAG=b7d9d,NX=12,NY=24,ID=1"  -L "node=6"  dales-fftw-fugaku.job
# pjsub -x "TAG=b7d9d,NX=16,NY=24,ID=1"  -L "node=8"  dales-fftw-fugaku.job
# pjsub -x "TAG=b7d9d,NX=24,NY=16,ID=1"  -L "node=8"  dales-fftw-fugaku.job
# pjsub -x "TAG=b7d9d,NX=24,NY=24,ID=1"  -L "node=12"  dales-fftw-fugaku.job
# pjsub -x "TAG=b7d9d,NX=24,NY=48,ID=1"  -L "node=24"  dales-fftw-fugaku.job
# pjsub -x "TAG=b7d9d,NX=48,NY=48,ID=1"  -L "node=48"  dales-fftw-fugaku.job

