# collect and tidy SAHIE data from the US Census website 
# René Dario Herrera 
# renedherrera at email dot arizona dot edu 
# 9 July 2021 

# data source citation:
# https://www.census.gov/programs-surveys/sahie.html

# set up ####
# load package libraries 
library(here)
library(curl)
library(tidyverse)
library(janitor)

# download dataset 
# set values 
# url <- "https://www2.census.gov/programs-surveys/sahie/datasets/time-series/estimates-acs/sahie-2019-csv.zip"
# path_zip <- "data/raw"
# path_unzip <- "data/raw/sahie_2019"
# zip_file <- "sahie_2019.zip"
# 
# # use curl to download 
# curl_download(url,
#               destfile = paste(path_zip, zip_file, sep = "/"))
# 
# # set value 
# zipped_file <- "data/raw/sahie_2019.zip"
# 
# # unzip to folder
# unzip(zipped_file, exdir = path_unzip)

# read directly 
sahie_2019 <- read_csv(file = "data/raw/sahie_2019/sahie_2019.csv",
                        col_types = cols(geocat = col_factor(levels = c("40", "50"), ordered = TRUE),
                                         agecat = col_factor(levels = c("0", "1", "2", "3", "4", "5"), ordered = TRUE),
                                         racecat = col_factor(levels = c("0", "1", "2", "3"), ordered = TRUE),
                                         sexcat = col_factor(levels = c("0", "1", "2"), ordered = TRUE),
                                         iprcat = col_factor(levels = c("0", "1", "2", "3", "4", "5"), ordered = TRUE)), 
                        skip=79) %>%
  clean_names()

# inspect 
glimpse(sahie_2019)
str(sahie_2019)

# exploration ####
make_chart_of_variable_frequencies <- function(x, the_variable) {
  the_plot <- x %>%
    count({{the_variable}}) %>%
    ggplot(mapping = aes(x = {{the_variable}}, y = n)) +
    geom_bar(stat = "identity")
  the_plot
  }

# State
# statefips
# Unique FIPS code for each state
make_chart_of_variable_frequencies(sahie_2019, statefips)

# County
# countyfips
# Unique FIPS code for each county within a state
make_chart_of_variable_frequencies(sahie_2019, countyfips)

# geocat
# Geography category:
# 40 –State geographic identifier
# 50 –County geographic identifier
make_chart_of_variable_frequencies(sahie_2019, geocat)

# agecat
# Age category
# 0 –Under 65 years
# 1 –18 to 64 years
# 2 –40 to 64 years
# 3 –50 to 64 years
# 4 –Under 19 years
# 5 –21 to 64 years
make_chart_of_variable_frequencies(sahie_2019, agecat)

# change the value of the levels 
sahie_2019$agecat_labels <- fct_recode(sahie_2019$agecat,
                                "Under 65 years" = "0",
                                "18 to 64 years" = "1",
                                "40 to 64 years" = "2",
                                "50 to 64 years" = "3",
                                "Under 19 years" = "4",
                                "21 to 64 years" = "5")

# racecat
# Race category
# 0 –All races
# Only state estimates have racecat=1,2,3 values
# 1 –White alone, not Hispanic
# 2 –Black alone, not Hispanic
# 3 –Hispanic (any race)
make_chart_of_variable_frequencies(sahie_2019, racecat)

# change the value of the levels 
sahie_2019$racecat_labels <- fct_recode(sahie_2019$racecat,
                                      "All races" = "0",
                                      "White alone, not Hispanic" = "1",
                                      "Black alone, not Hispanic" = "2",
                                      "Hispanic (any race)" = "3")

# sexcat
# Sex category
# 0 –Both sexes
# 1 -Male
# 2-Female
make_chart_of_variable_frequencies(sahie_2019, sexcat)

# change the value of the levels 
sahie_2019$sexcat_labels <- fct_recode(sahie_2019$sexcat,
                                        "Both sexes" = "0",
                                        "Male" = "1",
                                        "Female" = "2")

# iprcat
# Income category
# 0 –All income levels
# 1 –At or below 200% of poverty
# 2 –At or below 250% of poverty
# 3 –At or below 138% of poverty
# 4 –At or below 400% of poverty
# 5 –Between 138% -400% of poverty 
make_chart_of_variable_frequencies(sahie_2019, iprcat)

# change the value of the levels 
sahie_2019$iprcat_labels <- fct_recode(sahie_2019$iprcat,
                                       "All income levels" = "0",
                                       "At or below 200% of poverty" = "1",
                                       "At or below 250% of poverty" = "2",
                                       "At or below 138% of poverty" = "3",
                                       "At or below 400% of poverty" = "4",
                                       "Between 138% -400% of poverty" = "5")
# NIPR
# Number in demographic group for <income category>
ggplot(sahie_2019) +
  geom_histogram(mapping = aes(x = log(nipr)))

# NUI
# Number uninsured
ggplot(sahie_2019) +
  geom_histogram(mapping = aes(x = log(nui)))

# NIC
# Number insured
ggplot(sahie_2019) +
  geom_histogram(mapping = aes(x = log(nic)))

# PCTUI
# Percent uninsured in demographic group for <income category>
ggplot(sahie_2019) +
  geom_histogram(mapping = aes(x = (pctui)))

# PCTIC
# Percent insured in demographic group for <income category>
ggplot(sahie_2019) +
  geom_histogram(mapping = aes(x = (pctic)))

# PCTELIG
# Percent uninsured in demographic group for all income levels
ggplot(sahie_2019) +
  geom_histogram(mapping = aes(x = (pctelig)))

# PCTLIIC
# PPercent insured in demographic group for all income levels
ggplot(sahie_2019) +
  geom_histogram(mapping = aes(x = (pctliic)))

# state_name
# State name
make_chart_of_variable_frequencies(sahie_2019, state_name) +
  coord_flip()

# county_name
# County name
sahie_2019 %>%
  count(county_name, sort = TRUE) %>%
  top_n(10)

write_rds(sahie_2019, "data/tidy/sahie_2019.rds")

