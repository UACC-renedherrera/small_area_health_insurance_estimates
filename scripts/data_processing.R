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

# read data for az
sahie_2019_az <- read_rds("data/tidy/sahie_2019_az.rds")

# get values for az
# percent uninsured in AZ ####
# for all the state
sahie_2019_az %>%
  filter(geocat == "40",
         agecat == "0",
         racecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  select(pctui)

# az: age ####
# grouped by agecat

# az: age, race #### 
# grouped by agecat, racecat

# az: age, race, sex #### 
# grouped by agecat, racecat, sexcat

# az: age, race, income #### 
# grouped by agecat, racecat, iprcat

# az: age, race, sex, income #### 
# grouped by agecat, racecat, sexcat, iprcat

# az: age, sex #### 
# grouped by agecat, sexcat

# az: age, sex, income #### 
# grouped by agecat, sexcat, iprcat

# az: age, income #### 
# grouped by agecat, iprcat

# az: race #### 
# grouped by racecat

# az: race, sex #### 
# grouped by racecat, sexcat

# az: race, income #### 
# grouped by racecat, iprcat

# az: sex #### 
# grouped by sexcat

# az: sex, income #### 
# grouped by sexcat, iprcat

# az: income #### 
# grouped by iprcat

# az: age #### 
# grouped by age
sahie_2019_az %>%
  filter(geocat == "40",
         racecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  group_by(agecat) %>%
  select(agecat_labels, pctui) %>%
  arrange(desc(pctui))

# az: race #### 
# grouped by race
sahie_2019_az %>%
  filter(geocat == "40",
         agecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  group_by(racecat) %>%
  select(racecat_labels, pctui) %>%
  arrange(desc(pctui))

# az: sex #### 
# grouped by sex
sahie_2019_az %>%
  filter(geocat == "40",
         agecat == "0",
         racecat == "0",
         iprcat == "0") %>%
  group_by(sexcat) %>%
  select(sexcat_labels, pctui) %>%
  arrange(desc(pctui))

# az: income #### 
# grouped by income category
sahie_2019_az %>%
  filter(geocat == "40",
         agecat == "0",
         racecat == "0",
         sexcat == "0") %>%
  group_by(iprcat) %>%
  select(iprcat_labels, pctui) %>%
  arrange(desc(pctui))

# az: age, race #### 
# grouped by age and race
sahie_2019_az %>%
  filter(geocat == "40",
         sexcat == "0",
         iprcat == "0") %>%
  group_by(agecat, racecat) %>%
  select(agecat_labels, racecat_labels, pctui) %>%
  arrange(desc(pctui))

# az: age, race, sex #### 
# grouped by age and race
sahie_2019_az %>%
  filter(geocat == "40",
         iprcat == "0") %>%
  group_by(agecat, racecat, sexcat) %>%
  select(agecat_labels, racecat_labels, sexcat_labels, pctui) %>%
  arrange(desc(pctui))
# az: age, sex #### 
# grouped by age and sex
sahie_2019_az %>%
  filter(geocat == "40",
         racecat == "0",
         iprcat == "0") %>%
  group_by(agecat, sexcat) %>%
  select(agecat_labels, sexcat_labels, pctui) %>%
  arrange(desc(pctui))

# az: age, sex, income #### 
# grouped by age and sex
sahie_2019_az %>%
  filter(geocat == "40",
         racecat == "0") %>%
  group_by(agecat, sexcat, iprcat) %>%
  select(agecat_labels, sexcat_labels, iprcat_labels, pctui) %>%
  arrange(desc(pctui))

# az: age, sex, race #### 
# grouped by age and sex
sahie_2019_az %>%
  filter(geocat == "40",
         iprcat == "0") %>%
  group_by(agecat, sexcat, racecat) %>%
  select(agecat_labels, sexcat_labels, racecat_labels, pctui) %>%
  arrange(desc(pctui))

# az: age, sex, income #### 
# grouped by age and sex and income
sahie_2019_az %>%
  filter(geocat == "40",
         racecat == "0") %>%
  group_by(agecat, sexcat, iprcat) %>%
  select(agecat_labels, sexcat_labels, iprcat_labels, pctui) %>%
  arrange(desc(pctui))

# az: age, sex, income, race #### 
# grouped by race & age and sex and income
sahie_2019_az %>%
  filter(geocat == "40") %>%
  group_by(racecat, agecat, sexcat, iprcat) %>%
  select(racecat_labels, agecat_labels, sexcat_labels, iprcat_labels, pctui) %>%
  arrange(desc(pctui))

# az: race
# grouped by race
sahie_2019_az %>%
  filter(geocat == "40",
         agecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  group_by(racecat) %>%
  select(racecat_labels, pctui) %>%
  arrange(desc(pctui))

# az: race, age
# grouped by race
sahie_2019_az %>%
  filter(geocat == "40",
         sexcat == "0",
         iprcat == "0") %>%
  group_by(racecat, agecat) %>%
  select(racecat_labels, agecat_labels, pctui) %>%
  arrange(desc(pctui))

# grouped by sex
sahie_2019_az %>%
  filter(geocat == "40",
         agecat == "0",
         racecat == "0",
         iprcat == "0") %>%
  group_by(sexcat) %>%
  select(sexcat_labels, pctui)

# grouped by income
sahie_2019_az %>%
  filter(geocat == "40",
         agecat == "0",
         racecat == "0",
         sexcat == "0") %>%
  group_by(iprcat) %>%
  select(iprcat_labels, pctui)

# percent uninsured for each AZ county ####
sahie_2019_az %>%
  filter(geocat == "50",
         agecat == "0",
         racecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  select(county_name, pctui)

# grouped by age
sahie_2019_az %>%
  filter(geocat == "50",
         racecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  group_by(county_name, agecat) %>%
  select(county_name, agecat_labels, pctui)

# grouped by race redundant because there is no race data reported at the county level
# sahie_2019_az %>%
#   filter(geocat == "50",
#          agecat == "0",
#          sexcat == "0",
#          iprcat == "0") %>%
#   group_by(racecat) %>%
#   select(county_name, racecat_labels, pctui)

# grouped by sex
sahie_2019_az %>%
  filter(geocat == "50",
         agecat == "0",
         racecat == "0",
         iprcat == "0") %>%
  group_by(county_name, sexcat) %>%
  select(county_name, sexcat_labels, pctui)

# grouped by income
sahie_2019_az %>%
  filter(geocat == "50",
         agecat == "0",
         racecat == "0",
         sexcat == "0") %>%
  group_by(county_name, iprcat) %>%
  select(county_name, iprcat_labels, pctui)

# catchment only
sahie_2019_az_uazcc <- read_rds("data/tidy/sahie_2019_az.rds") %>%
  filter(uazcc_catchment == "yes")

# percent uninsured in AZ ####
# for all the state
sahie_2019_az %>%
  filter(geocat == "40",
         agecat == "0",
         racecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  select(pctui)

# grouped by age
sahie_2019_az %>%
  filter(geocat == "40",
         racecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  group_by(agecat) %>%
  select(agecat_labels, pctui)

# grouped by race
sahie_2019_az %>%
  filter(geocat == "40",
         agecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  group_by(racecat) %>%
  select(racecat_labels, pctui)

# grouped by sex
sahie_2019_az %>%
  filter(geocat == "40",
         agecat == "0",
         racecat == "0",
         iprcat == "0") %>%
  group_by(sexcat) %>%
  select(sexcat_labels, pctui)

# grouped by income
sahie_2019_az %>%
  filter(geocat == "40",
         agecat == "0",
         racecat == "0",
         sexcat == "0") %>%
  group_by(iprcat) %>%
  select(iprcat_labels, pctui)

# percent uninsured for each UAZCC county ####
sahie_2019_az_uazcc %>%
  filter(geocat == "50",
         agecat == "0",
         racecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  select(county_name, pctui)

# grouped by age
sahie_2019_az_uazcc %>%
  filter(geocat == "50",
         racecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  group_by(county_name, agecat) %>%
  select(county_name, agecat_labels, pctui)

# grouped by race redundant because there is no race data reported at the county level
# sahie_2019_az %>%
#   filter(geocat == "50",
#          agecat == "0",
#          sexcat == "0",
#          iprcat == "0") %>%
#   group_by(racecat) %>%
#   select(county_name, racecat_labels, pctui)

# grouped by sex
sahie_2019_az_uazcc %>%
  filter(geocat == "50",
         agecat == "0",
         racecat == "0",
         iprcat == "0") %>%
  group_by(county_name, sexcat) %>%
  select(county_name, sexcat_labels, pctui)

# grouped by income
sahie_2019_az_uazcc %>%
  filter(geocat == "50",
         agecat == "0",
         racecat == "0",
         sexcat == "0") %>%
  group_by(county_name, iprcat) %>%
  select(county_name, iprcat_labels, pctui)

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
