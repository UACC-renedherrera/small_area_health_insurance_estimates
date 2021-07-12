# process SAHIE data from the US Census
# René Dario Herrera
# renedherrera at email dot arizona dot edu
# 9 July 2021

# data source citation:
# https://www.census.gov/programs-surveys/sahie.html

# set up ####
# load package libraries
library(here)
library(tidyverse)
library(tigris)
library(sf)

# enable caching of data
options(tigris_use_cache = TRUE)

# read data
sahie_2019_az <- read_rds("data/tidy/sahie_2019_az.rds")

# catchment only
sahie_2019_az_uazcc <- read_rds("data/tidy/sahie_2019_az.rds") %>%
  filter(uazcc_catchment == TRUE)

# get az county spatial data from tigris
az_counties <- counties(state = "04") %>%
  janitor::clean_names()

# join spatial tigris data with non-spatial data frame
sahie_2019_az_spatial <- geo_join(
  spatial_data = az_counties,
  data_frame = sahie_2019_az,
  by_sp = "name",
  by_df = "county_name",
  how = "inner"
)

# catchment only
sahie_2019_az_uazcc_spatial <- geo_join(
  spatial_data = az_counties,
  data_frame = sahie_2019_az_uazcc,
  by_sp = "name",
  by_df = "county_name",
  how = "inner"
)

# write spatial data to disk
# RDS
write_rds(sahie_2019_az_spatial, file = "data/tidy/sahie_2019_az_spatial.rds")

# ESRI shapefile
write_sf(
  obj = sahie_2019_az_spatial,
  dsn = "data/spatial/sahie_2019_az_spatial/sahie_2019_az_spatial.shp"
)

# because there is no race data available at the county level this does not display any information
# # comparing insurance rates grouped by race and catchment
# sahie_2019_az %>%
#   group_by(uazcc_catchment, racecat_labels) %>%
#   filter(countyfips != "000",
#          agecat == "0",
#          sexcat == "0",
#          iprcat == "0") %>%
#   summarise(nui = sum(nui),
#             nipr = sum(nipr)) %>%
#   mutate(pctui = 100*(nui/nipr)) %>%
#   ggplot() +
#   geom_bar(mapping = aes(x = racecat_labels, y = pctui, fill = uazcc_catchment), position = "dodge", stat = "identity") +
#   coord_flip()
