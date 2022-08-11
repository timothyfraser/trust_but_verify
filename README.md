# "Trust but Verify: Validating New Measures for Mapping Social Infrastructure in Cities"

## Replication Code and Data Repository

*Authors*: Timothy Fraser, Napuck Cherdchaiyapong, Winta Tekle, Erin Thomas, Joel Zayas, Courtney Page-Tan, Daniel P. Aldrich

*Contact*: [Timothy Fraser](https://github.com/timothyfraser)

This repository shares data and code needed for replicating this study! In the hopes that others will use this data too, we have tried our best to outline every single step necessary to replicate our analyses, particularly our query code for the Google Maps API. (We've already queried quite a number of American cities; hoping to release that data sometime in the near future.)

Below, we briefly outline the structure of this repository.

## Replication

- `README.md`: You made it! This is the README document for introducing this repository.

- `code.Rmd`: replication file for study, with code written in RMarkdown. Produces all tables and visuals in the study.

- `code.html`: For a user-friendly version of `code.Rmd`, see our tutorial, which is an HTML-rendered version of the `code.Rmd` file.

- `keys.R`: A simple short script that sets API keys, tokens, and passwords to the `R` environment. This is specific to each user (you'll need your own). But, we provide a sample code in the `code.Rmd` file to show you how to make your own `keys.R` file.

- `meta.txt`: A text file containing several lists of frequently used metadata, including spatial reference projections, useful vectors of `cell_id` values, etc. Generated in `code.Rmd` and frequently used throughout the code. 


## Folders

- `query`: folder containing our Google API query results. Key files of interest include:

  - `query/sites_validated.csv`: sites analyzed in this study, with each site annotated in a `status` column to describe it (eg. `checked` vs. `not social infrastructure`).
  
  - `query/social_infrastructure_sites.csv`: actual social infrastructure sites identified in this study!

- `data`: contains datasets used to produce `covariates`, `transit` data, elevation `contour` data, `sampling` data for ground-truthing, etc. Also contains `figure_rates.csv`, `models.csv`, and several other files, which are frequently used in code to generate figures.

- `shapes`: folder containing *lots* of geographic data, all stored as `.geojson` files and openable with `read_sf()` in the `sf` package in `R`. Key files of interest include `shapes/grid_covariates.geojson`, which shows the covariates for each grid cell.

- `helper`: contains a few minor datasets and scripts used to support the `code.Rmd` replication file. An important one includes `cell_zones.csv`, which specifies which `zone` each of our grid cells was sorted into based on local context.

- `icons`: folder containing publicly available `fontawesome` icons and other small images used in figures.

- `figure`: folder containing all figures for this paper!


## Using this data

We do hope you use the data, and we would love to hear from you if you do!
Please be sure to cite the dataset and our validation study!
The following 2 files may be of particular use:

- `query/social_infrastructure_sites_boston.csv`: the final validated set of actual social infrastructure sites we located in Boston, geocoded.

- `query/grid_covariates.geojson`: our grid of 1 km<sup>2</sup> cells, with spatially averaged covariates, including several measures of social capital.
