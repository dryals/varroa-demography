# varroa-demography

<!--- 
understand what each piece of code does...

describe repo, what is in each folder, instructions on how to run scripts, explain simlinks (and data not included)
explain where to find data (ncbi eventually) 
--->

All scripts were run on the FASRC Cannon cluster, and are designed for cluster computing.
Bash scripts begining with one or more numerals (e.g., `3_pca/2_make_bam.sh`) are designed to
run in ascending order of their numerals. Additional subdirectories and large data files are excluded from this repository, 
but all can be reconstructed by running these scripts. R markdown scripts were run outside of the cluster on a comsumer laptop.
These are all run *after* bash scripts and rely on their products. 


##  Directories

- 2_ipyrad
  - scripts for assembling raw reads using `ipyrad`
  - `params-P#.txt` parameter files contain barcode information for demultiplexing 
    samples from each pool
  - `params-varroa.txt` combines all pools for remaining ipyrad steps 
- 3_pca
- 4_gendist
- 5_fastsimcoal
- 7_diversity
- 8_mapping
  - script for producing map in figure 1a
  - `map` subdirectory contains (large) data file not included in this repository. This
    can be downloaded locally in the beginning of `mapping.Rmd`
  - 
- 9_tables
