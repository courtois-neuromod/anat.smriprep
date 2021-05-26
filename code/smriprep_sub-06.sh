#!/bin/bash
#SBATCH --account=rrg-pbellec
#SBATCH --job-name=smriprep_sub-06.job
#SBATCH --output=/lustre03/project/6003287/datasets/cneuromod_processed/smriprep/code/smriprep_sub-06.out
#SBATCH --error=/lustre03/project/6003287/datasets/cneuromod_processed/smriprep/code/smriprep_sub-06.err
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=4096M
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=basile.pinsard@gmail.com

export SINGULARITYENV_FS_LICENSE=$HOME/.freesurfer.txt
export SINGULARITYENV_TEMPLATEFLOW_HOME=/templateflow
singularity run --cleanenv -B $SLURM_TMPDIR:/work -B /scratch/bpinsard/templateflow:/templateflow -B /etc/pki:/etc/pki/ -B /lustre03/project/6003287/datasets/cneuromod_processed/smriprep:/lustre03/project/6003287/datasets/cneuromod_processed/smriprep /lustre03/project/6003287/datasets/cneuromod/code/ds_prep/containers/fmriprep-20.2.1lts.sif -w /work --participant-label 06 --anat-only --bids-database-dir /lustre03/project/6003287/datasets/cneuromod_processed/smriprep/sourcedata/raw/.pybids_cache --bids-filter-file /lustre03/project/6003287/datasets/cneuromod_processed/smriprep/sourcedata/raw/code/bids_filters.json --output-layout bids --output-spaces MNI152NLin2009cAsym MNI152NLin6Asym --cifti-output 91k --skip_bids_validation --write-graph --omp-nthreads 8 --nprocs 16 --mem_mb 65536 /lustre03/project/6003287/datasets/cneuromod_processed/smriprep/sourcedata/raw /lustre03/project/6003287/datasets/cneuromod_processed/smriprep participant 
fmriprep_exitcode=$?
cp $SLURM_TMPDIR/fmriprep_wf/resource_monitor.json /scratch/bpinsard/smriprep_sub-06_resource_monitor.json 
if [ $fmriprep_exitcode -ne 0 ] ; then cp -R $SLURM_TMPDIR /scratch/bpinsard/smriprep_sub-06.workdir ; fi 
exit $fmriprep_exitcode 
