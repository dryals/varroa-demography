# varroa-demography

<!--- 
understand what each piece of code does...

describe repo, what is in each folder, instructions on how to run scripts, explain simlinks (and data not included)
explain where to find data (ncbi eventually) 
--->

All scripts were run on the FASRC Cannon cluster, and are designed for cluster computing. All directories are completed in order
of their leading numerals. Similarly, 
bash scripts (e.g., `3_pca/2_make_bam.sh`) are designed to
run in ascending order of their numerals within directories.
Additional subdirectories and large data files are excluded from this repository, 
but all can be reconstructed by running these scripts. R markdown scripts were run outside of the cluster on a comsumer laptop
*after* bash scripts and often rely on their products. 


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
    - this means scripts in `8_mapping` must be run before figure 1 can be generated  
  - `pop_view.rmd` simply counts samples per populaiton, and has no downstream products
- 4_gendist
  - bash script calculates pairwise genetic distance between samples
  - `gendist.Rmd` calculates pairwise geographic distance between samples, and combines with the product of the above script
    to generate the Isolation by Distance test. It also computes mantel tests for significance.
- 5_fastsimcoal
  - bash scripts calculate 2D site frequency spectra for populations, create a filestructure for `fastsimcoal` results,
    run simulations, and finally compile simulations that resulted in maximum liklihood outcomes
  - `template.est` and `template.tpl` are example parameter files which each need to be provided for each
    population in the (respective population subdirectory), completed with population sample sizes (as in subdir `pops_bystate`)
- 7_diversity
  - scripts within calculate various summary statistics for genetic diversity
  - global and by-population statistics are calculated seperately in their respective directories, following similar workflows
  - statistics are calculated within 10000bp windows, then averaged across populations and globally in `thetas.Rmd`
  - heterozygosity is calculated per individual across all sites (`pops/3_het_est.sh`) and across only sites 
    passing the Hardy-Weinberg filter created during PCA (`het_hwe/0_het_est_hwe.sh`). These are averaged across populations and 
    globally in `estimate_heterozygosity.Rmd`
- 8_mapping
  - script for producing map in figure 1a
  - `map` subdirectory contains (large) data file not included in this repository. This
    can be downloaded locally in commented-out section of `mapping.Rmd`
- 9_tables
  - `sample_stats.Rmd` breaks samples down by extractions, sequencing, inclusion in final analysis, and population
  - .csv files generated in `7_diversity` and `sample_stats.Rmd` are (manually) compiled into `tables.xlsx`, 
    which stores data for all tables in manuscript
