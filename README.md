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
  - bash scripts assemle and deduplicate reads, generate liklihoods via `angsd`, filter out
    sites not within Hardy-Weinberg equilibrium, and calculate a PCA
  - `PCA_view.Rmd` visualizes the PCA and combines it with map information (8_mapping) to produce figure 1
  - `pop_view.rmd` simply counts samples per populaiton, and has no downstream products
- 4_gendist
  - bash script calculates pairwise genetic distance between samples
  - `gendist.Rmd` calculates pairwise geographic distance between samples, and combines with the product of the above script
    to generate the Isolation by Distance test. It also computes mantel tests for significance.  
- 5_fastsimcoal
- 7_diversity
- 8_mapping
  - script for producing map in figure 1a
  - `map` subdirectory contains (large) data file not included in this repository. This
    can be downloaded locally in the beginning of `mapping.Rmd`
  - 
- 9_tables
