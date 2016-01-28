#!/bin/bash
#SBATCH --time=0:01:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=100000
#SBATCH --job-name=create_parameters_article
#SBATCH --mail-type=BEGIN,END
module load R
./create_parameters_article.sh