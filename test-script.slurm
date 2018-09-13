#!/bin/bash -l
# NOTE the -l flag!
#    see explanation at https://stackoverflow.com/questions/20499596/bash-shebang-option-l

# submit me via `sbatch test-script.slurm`

# Job info
#SBATCH --job-name=out
#SBATCH -o out-%j.output
#SBATCH -e out-%j.output

# Resource allocation
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=high

## ###SBATCH --mem=64000

#SBATCH –-mail-user=mjagerton@ucdavis.edu
#SBATCH --mail-type=ALL

hostname
module load julia/0.7.0

# this starts the julia script which will srun its own processes
julia test-script.jl $SLURM_NTASKS
