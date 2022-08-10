
library(tidyverse)
library(sf)

# Import metadata
meta <- dget("meta.txt")

# Import tracts
tracts <- read_sf("shapes/tracts.geojson") %>%
  st_transform(crs= meta$aea$proj) 

# Import Boston boundaries
boston <- read_sf("shapes/boston.geojson") %>%
  st_transform(crs = meta$aea$proj)

# Load in Suffolk county background
county <- read_sf("shapes/county.geojson") %>%
  st_transform(crs= meta$aea$proj)

# Import fishnet grid
grid <- read_sf("shapes/grid_covariates.geojson") %>%
  st_transform(crs= meta$aea$proj)

