#!/bin/bash -l
# NOTE the -l flag!
#    see https://stackoverflow.com/questions/20499596/bash-shebang-option-l

#-----------------------
# Job info
#-----------------------

#SBATCH --job-name=out
#SBATCH -o out-%j.output
#SBATCH -e out-%j.output
#SBATCH --mail-user=mjagerton@ucdavis.edu
#SBATCH --mail-type=ALL

#-----------------------
# Resource allocation
#-----------------------

#SBATCH --time=1:00:00     # in hours
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=high

##SBATCH --mem=64000       # uncomment to max out RAM

#-----------------------
# script
#-----------------------

hostname
module load julia/0.7.0

# run the script
julia test-script.jl

## this also works AS LONG AS we don't set the number of threads using
##   ENV["SLURM_NTASKS"]
#srun --ntasks=1 julia test-script.jl 

## this DOES NOT. SLURM does everything multiple times
## srun julia test-script.jl
