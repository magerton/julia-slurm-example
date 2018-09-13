Simple example scripts for running Julia on a SLURM 

These scripts are based on examples in the
 [ACCRE/SLURM repo](https://github.com/accre/SLURM)

# About

When running Julia on a cluster using SLURM, we have to do 2 things

1. Run Julia through a SLURM `sbatch` script
2. Tell Julia to use [ClusterManagers.jl](https://github.com/JuliaParallel/ClusterManagers.jl) and the appropriate `addprocs` function
    ```julia
    using ClusterManagers

    addprocs_slurm(np::Int)
    # or
    addprocs(SlurmManager(np::Int))
    ```
    We can also keep compatibility with non-SLURM parallel computing by doing something like
    ```julia
    const IN_SLURM = "SLURM_JOBID" in keys(ENV)

    IN_SLURM && using ClusterManagers

    if IN_SLURM
        pids = addprocs_slurm(parse(Int, ENV["SLURM_NTASKS"]))
        print("\n")
    else
        pids = addprocs()
    end
    ```


## Some Julia/SLURM info

- <https://github.com/JuliaParallel/ClusterManagers.jl/issues/84#issuecomment-354536208>
- <http://www.stochasticlifestyle.com/multi-node-parallelism-in-julia-on-an-hpc/>
- <https://stackoverflow.com/questions/48631411/julia-and-slurm-setup>
- <https://discourse.julialang.org/t/issues-with-machinefile-and-slurm/7882/3>
- <https://wiki.cse.ucdavis.edu/support/hpc/software/slurm>
