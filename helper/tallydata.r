
# Get stack of points, including
sites <- bind_rows(
  # A set of just the total points (having excluded the Others like museums)
  read_csv("query/sites_validated.csv") %>%
    filter(type != "Other") %>%
    mutate(type = "Total"),
  # And the rest of points, delineated by type
  read_csv("query/sites_validated.csv") %>%
    filter(type != "Other"))

# Get sites
grid <- read_sf("shapes/grid_covariates.geojson") %>%
  as_tibble() %>%
  select(cell_id, zone, pop_density_int) %>%
  # Stack data.frame on itself 6 times, creating several versions per type we want to tally 
  expand_grid(., type = c("Total", "Community Spaces", "Places of Worship", 
                          "Social Businesses", "Parks"))

# Let us write a function to tally up any set of points supplied
tallyup = function(points, zones = grid$zone %>% unique()){
  
  # Filter to match the specified zone above in zones
  mygrid <- grid %>%
    # Defaults to all zones in grid object
    filter(zone %in% zones)
  
  
  # If points is grouped,
  # maintain the groups
  if(!is.null(attr(points, "group"))){
    # Extract the grouping variable names
    thegroups <- attr(points, "group") %>% select(-.rows)
    
    # Now make as many grids as there are values in those groups,
    # so that each grid contains the values and variable names of those groups
    mygrid <- expand_grid(thegroups, mygrid)
    
    # Extract the names of those variables
    mygroups <- thegroups %>% names() %>%
      # Add these key ones
      c(., "type", "cell_id") %>%
      # Keep just unique variables
      unique()
    
  }else{
    mygroups <- c("type", "cell_id")
  }
  
  # Otherwise, just use these variables to group
  points %>%
    group_by(across(.cols = c(mygroups))) %>%
    # Tally up total points per cell per type
    summarize(count = sum(!is.na(id))) %>%
    # Join tally into the grid
    right_join(by = mygroups, y = mygrid) %>%
    # If NA, that means there are no sites; so that should get a zero
    mutate(count = if_else(is.na(count), 0, as.numeric(count))) %>%
    # Calculate rate of folks in the grid cell,
    # using interpolated population density per grid cell
    mutate(rate = count / pop_density_int * 1000) %>% 
    ungroup() %>%
    return()
}


