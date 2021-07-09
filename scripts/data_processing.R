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

# read data 
sahie_2019_az <- read_rds("data/tidy/sahie_2019.rds") %>%
  filter(state_name == "Arizona")