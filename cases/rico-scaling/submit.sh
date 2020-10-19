#!/bin/bash

# baseline 4.2 branch
sbatch --array=1 -n 48  --export=TAG=4.2,NX=6,NY=8   dales-fftw-1152.job
sbatch --array=1 -n 72  --export=TAG=4.2,NX=6,NY=12  dales-fftw-1152.job
sbatch --array=1 -n 144 --export=TAG=4.2,NX=12,NY=12 dales-fftw-1152.job
sbatch --array=1 -n 288 --export=TAG=4.2,NX=24,NY=12 dales-fftw-1152.job
sbatch --array=1 -n 576 --export=TAG=4.2,NX=24,NY=24 dales-fftw-1152.job

# to4.3_Fredrik_micro
sbatch --array=1 -n 48  --export=TAG=9d83a,NX=6,NY=8   dales-fftw-1152.job
sbatch --array=1 -n 72  --export=TAG=9d83a,NX=6,NY=12  dales-fftw-1152.job
sbatch --array=1 -n 144 --export=TAG=9d83a,NX=12,NY=12 dales-fftw-1152.job
sbatch --array=1 -n 288 --export=TAG=9d83a,NX=24,NY=12 dales-fftw-1152.job
sbatch --array=1 -n 576 --export=TAG=9d83a,NX=24,NY=24 dales-fftw-1152.job

