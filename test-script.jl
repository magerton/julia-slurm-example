# To run parallel jobs in SLURM, we need the
# ClusterManagers package, which
# can be installed with the command
# `Pkg.add("ClusterManagers")`

# Recall we asked for 5 processes in the `.slurm` file.
# This managing process is one of those processes, so
# now we can spin off 4 more.
# These are created using either `addprocs_slurm(4)` or
# `addprocs(SlurmManager(4))`.

# This will create worker instances that work the same way
# (from your perspective) as
# the workers that would be created if you'd launched julia
# on your own computer with `julia -p 4` or as if you'd
# openned Julia and run
# `addprocs(4)`

typeof(ARGS) <: Vector{String} || throw(error("args must be string"))
length(ARGS) == 1 || throw(error("pass 1 arg only"))

using Distributed
using ClusterManagers

# Here we create our parallel julia processes
pids = addprocs_slurm(parse(Int, ARGS[1]))

# See ids of our workers. Should be length 4.
# The output of this `println` command will appear in the
# SLURM output file julia_in_parallel.output
println(workers())

# Here we ask everyone to say hi!
# Output will appear in julia_in_parallel.output
g = @sync @distributed (vcat) for w in workers()
    worker_id = myid()
    worker_host = gethostname()
    "Hello! I'm worker number $worker_id, and I reside on machine $worker_host. Nice to meet you!"
end

for i in g
   println(i)
end

rmprocs(pids)
println("procs removed")
