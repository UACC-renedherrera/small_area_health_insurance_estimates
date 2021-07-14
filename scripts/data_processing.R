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

# list of catchment counties
uazcc_catchment_counties <- c(
  "Cochise",
  "Pima",
  "Pinal",
  "Santa Cruz",
  "Yuma"
)

# read data #### 
sahie_az <- read_rds("data/tidy/sahie_az.rds")

# percent uninsured in AZ ####
# for all the state
# grouped by year
sahie_az %>%
  filter(geocat == "40",
         agecat == "0",
         racecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  group_by(year) %>%
  select(pctui)

# in the most recent year, 2019
# az: age ####
# grouped by agecat
sahie_az %>%
  filter(year == "2019", 
         geocat == "40",
         racecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  group_by(agecat) %>%
  select(agecat_labels, pctui) %>%
  arrange(desc(pctui))

# az: age, race #### 
# grouped by agecat, racecat
sahie_az %>%
  filter(year == "2019", 
         geocat == "40",
         sexcat == "0",
         iprcat == "0") %>%
  group_by(agecat, racecat) %>%
  select(agecat_labels, racecat_labels, pctui) %>%
  arrange(desc(pctui))

# az: age, race, sex #### 
# grouped by agecat, racecat, sexcat
sahie_az %>%
  filter(year == "2019", 
         geocat == "40",
         iprcat == "0") %>%
  group_by(agecat, racecat, sexcat) %>%
  select(agecat_labels, racecat_labels, sexcat_labels, pctui) %>%
  arrange(desc(pctui))

# az: age, race, income #### 
# grouped by agecat, racecat, iprcat
sahie_az %>%
  filter(year == "2019", 
         sexcat == "0",
         geocat == "40") %>%
  group_by(agecat, racecat, iprcat) %>%
  select(agecat_labels, racecat_labels, iprcat_labels, pctui) %>%
  arrange(desc(pctui))

# az: age, race, sex, income #### 
# grouped by agecat, racecat, sexcat, iprcat
sahie_az %>%
  filter(year == "2019",
         geocat == "40") %>%
  group_by(racecat, agecat, sexcat, iprcat) %>%
  select(racecat_labels, agecat_labels, sexcat_labels, iprcat_labels, pctui) %>%
  arrange(desc(pctui))

# az: age, sex #### 
# grouped by agecat, sexcat
sahie_az %>%
  filter(year == "2019",
         geocat == "40",
         racecat == "0",
         iprcat == "0") %>%
  group_by(agecat, sexcat) %>%
  select(agecat_labels, sexcat_labels, pctui) %>%
  arrange(desc(pctui))

# az: age, sex, income #### 
# grouped by agecat, sexcat, iprcat
sahie_az %>%
  filter(year == "2019",
         geocat == "40",
         racecat == "0") %>%
  group_by(agecat, sexcat, iprcat) %>%
  select(agecat_labels, sexcat_labels, iprcat_labels, pctui) %>%
  arrange(desc(pctui))

# az: age, income #### 
# grouped by agecat, iprcat
sahie_az %>%
  filter(year == "2019",
         geocat == "40",
         racecat == "0",
         sexcat == "0") %>%
  group_by(agecat, iprcat) %>%
  select(agecat_labels, iprcat_labels, pctui) %>%
  arrange(desc(pctui))

# az: race #### 
# grouped by racecat
sahie_az %>%
  filter(year == "2019",
         geocat == "40",
         agecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  group_by(racecat) %>%
  select(racecat_labels, pctui) %>%
  arrange(desc(pctui))

# az: race, sex #### 
# grouped by racecat, sexcat
sahie_az %>%
  filter(year == "2019",
         geocat == "40",
         agecat == "0",
         iprcat == "0") %>%
  group_by(racecat, sexcat) %>%
  select(racecat_labels, sexcat_labels, pctui) %>%
  arrange(desc(pctui))

# az: race, income #### 
# grouped by racecat, iprcat
sahie_az %>%
  filter(year == "2019",
         geocat == "40",
         agecat == "0",
         sexcat == "0") %>%
  group_by(racecat, iprcat) %>%
  select(racecat_labels, iprcat_labels, pctui) %>%
  arrange(desc(pctui))

# az: sex #### 
# grouped by sexcat
sahie_az %>%
  filter(year == "2019",
         geocat == "40",
         agecat == "0",
         racecat == "0",
         iprcat == "0") %>%
  group_by(sexcat) %>%
  select(sexcat_labels, pctui) %>%
  arrange(desc(pctui))

# az: sex, income #### 
# grouped by sexcat, iprcat
sahie_az %>%
  filter(year == "2019",
         geocat == "40",
         agecat == "0",
         racecat == "0") %>%
  group_by(sexcat, iprcat) %>%
  select(sexcat_labels, iprcat_labels, pctui) %>%
  arrange(desc(pctui))

# az: income #### 
# grouped by iprcat
sahie_az %>%
  filter(year == "2019",
         geocat == "40",
         agecat == "0",
         racecat == "0",
         sexcat == "0") %>%
  group_by(iprcat) %>%
  select(iprcat_labels, pctui) %>%
  arrange(desc(pctui))


# percent uninsured for each AZ county ####
sahie_az %>%
  filter(geocat == "50",
         agecat == "0",
         racecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  select(county_name, pctui)

# grouped by age
sahie_az %>%
  filter(geocat == "50",
         racecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  group_by(county_name, agecat) %>%
  select(county_name, agecat_labels, pctui)

# grouped by race redundant because there is no race data reported at the county level
# sahie_az %>%
#   filter(geocat == "50",
#          agecat == "0",
#          sexcat == "0",
#          iprcat == "0") %>%
#   group_by(racecat) %>%
#   select(county_name, racecat_labels, pctui)

# grouped by sex
sahie_az %>%
  filter(geocat == "50",
         agecat == "0",
         racecat == "0",
         iprcat == "0") %>%
  group_by(county_name, sexcat) %>%
  select(county_name, sexcat_labels, pctui)

# grouped by income
sahie_az %>%
  filter(geocat == "50",
         agecat == "0",
         racecat == "0",
         sexcat == "0") %>%
  group_by(county_name, iprcat) %>%
  select(county_name, iprcat_labels, pctui)

# catchment only
sahie_az_uazcc <- read_rds("data/tidy/sahie_az.rds") %>%
  filter(uazcc_catchment == "yes")

# percent uninsured for each UAZCC county ####
# in 2019
sahie_az_uazcc %>%
  filter(year == "2019",
         geocat == "50",
         agecat == "0",
         racecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  select(county_name, pctui)

# grouped by age
sahie_az_uazcc %>%
  filter(year == "2019",
         geocat == "50",
         racecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  group_by(county_name, agecat) %>%
  select(county_name, agecat_labels, pctui) %>%
  arrange(desc(pctui))

# grouped by sex
sahie_az_uazcc %>%
  filter(year == "2019",
         geocat == "50",
         agecat == "0",
         racecat == "0",
         iprcat == "0") %>%
  group_by(county_name, sexcat) %>%
  select(county_name, sexcat_labels, pctui) %>%
  arrange(desc(pctui))

# grouped by income
sahie_az_uazcc %>%
  filter(year == "2019",
         geocat == "50",
         agecat == "0",
         racecat == "0",
         sexcat == "0") %>%
  group_by(county_name, iprcat) %>%
  select(county_name, iprcat_labels, pctui) %>%
  arrange(desc(pctui))

# get az county spatial data from tigris
az_counties <- counties(state = "04") %>%
  janitor::clean_names()

# join spatial tigris data with non-spatial data frame
sahie_az_spatial <- geo_join(
  spatial_data = az_counties,
  data_frame = sahie_az,
  by_sp = "name",
  by_df = "county_name",
  how = "inner"
)

# catchment only
sahie_az_uazcc_spatial <- geo_join(
  spatial_data = az_counties,
  data_frame = sahie_az_uazcc,
  by_sp = "name",
  by_df = "county_name",
  how = "inner"
)

# write spatial data to disk
# RDS
write_rds(sahie_az_spatial, file = "data/tidy/sahie_az_spatial.rds")

# ESRI shapefile
write_sf(
  obj = sahie_az_spatial,
  dsn = "data/spatial/sahie_az_spatial/sahie_az_spatial.shp"
)

# write spatial data to disk
# RDS
write_rds(sahie_az_uazcc_spatial, file = "data/tidy/sahie_az_uazcc_spatial.rds")

# ESRI shapefile
write_sf(
  obj = sahie_az_spatial,
  dsn = "data/spatial/sahie_az_uazcc_spatial/sahie_az_uazcc_spatial.shp"
)
