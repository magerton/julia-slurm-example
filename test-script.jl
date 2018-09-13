# detect if using SLURM
const IN_SLURM = "SLURM_JOBID" in keys(ENV)

# load packages
using Distributed
IN_SLURM && using ClusterManagers

# Here we create our parallel julia processes
if IN_SLURM
    pids = addprocs_slurm(parse(Int, ENV["SLURM_NTASKS"]))
    print("\n")
else
    pids = addprocs()
end

# See ids of our workers. Should be same length as SLURM_NTASKS
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
