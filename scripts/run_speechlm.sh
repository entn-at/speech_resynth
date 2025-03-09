#!/bin/sh

#$ -cwd                      ## Execute a job in the current directory
#$ -l node_h=1               ## Use number of node
#$ -l h_rt=24:00:00          ## Running job time

module load cuda
module load intel
module load cudnn
module load nccl
module load openmpi

module load miniconda
eval "$(/apps/t4/rhel9/free/miniconda/24.1.2/bin/conda shell.bash hook)"
conda acivate py39

torchrun \
    --nnodes=1 \
    --nproc_per_node=2 \
    --rdzv_id=100 \
    --rdzv_backend=c10d \
    --rdzv_endpoint=localhost:29400 \
    main_speechlm.py train \
    --config=configs/speechlm/hubert.yaml