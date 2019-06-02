#!/bin/bash -l
# NOTE the -l flag!
#    see https://stackoverflow.com/questions/20499596/bash-shebang-option-l

#-----------------------
# Job info
#-----------------------

#SBATCH --mail-user=EMAIL@DOMAIN.COM   # update email address to get notifications
#SBATCH --mail-type=ALL
#SBATCH --job-name=MY_GREAT_TEST_JOB

# by default, slurm makes "slurm-%j.out" files w/ output. uncomment to change
##SBATCH --output out-%j.out
##SBATCH --error out-%j.out

#-----------------------
# Resource allocation
#-----------------------

#SBATCH --time=1:00:00     # in d-hh:mm:ss
#SBATCH --nodes=1          # single node
#SBATCH --ntasks=4         # number of virtual cores
#SBATCH --partition=med2   # partition

##SBATCH --mem=64000       # uncomment to max out RAM

#-----------------------
# script
#-----------------------

hostname
module load julia/1.1.1

# make job directory and switch to it
mkdir ${SLURM_JOB_ID}
cd ${SLURM_JOB_ID}

echo "Starting job!!! ${SLURM_JOB_ID}"

# print out environment variables related to SLURM_NTASKS
julia -e 'println("\n"); [println((k,ENV[k],)) for k in keys(ENV) if occursin("SLURM_NTASKS",k)]; println("\n");'

# run the script
julia --optimize=3 test-script.jl
