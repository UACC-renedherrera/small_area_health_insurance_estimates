# collect and tidy SAHIE data from the US Census website 
# René Dario Herrera 
# renedherrera at email dot arizona dot edu 
# 9 July 2021 

# data source citation:
# https://www.census.gov/programs-surveys/sahie.html

# set up ####
# load package libraries 
library(here)
library(tidyverse)
library(ggthemes)

# read data 
sahie_2019_az <- read_rds("data/tidy/sahie_2019.rds") %>%
  filter(state_name == "Arizona")

# set theme #### 
# set consistent theme for graphics & data visualizations
theme_uazcc_brand <- theme_clean() +
  theme(
    text = element_text(family = "sans",
                        face = "bold",
                        color = "#001C48",
                        size = 12),
    panel.background = element_rect(fill = "white"),
    panel.grid = element_line(color = "#1E5288"),
    plot.background = element_rect(fill = "#EcE9EB"),
    aspect.ratio = 2/3,
    legend.background = element_rect(fill = "white"),
    legend.position = "bottom",
    plot.caption = element_text(size = 10),
    plot.subtitle = element_text(size = 14),
    plot.title = element_text(size = 16),
    strip.background = element_rect(fill = "#EcE9EB"))

#### viz 1 by county #### 
# percent uninsured for all income groups in each county 
sahie_2019_az %>%
  filter(countyfips != "000",
         agecat == "0",
         racecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  ggplot(mapping = aes(x = reorder(county_name, pctelig), y = pctelig)) +
  geom_bar(fill = "#1E5288", stat = "identity") +
  geom_errorbar(aes(ymin = (pctelig-pctelig_moe), ymax = (pctelig+pctelig_moe)), color = "#001C48") +
  coord_flip() +
  # ylim(c(0,100)) +
  labs(title = "Percent Uninsured in Arizona Counties",
       subtitle = "2019, Under 65 years, All Races, Both Sexes, All Incomes",
       x = "County", 
       y = "Percent Uninsured",
       caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program") +
  theme_uazcc_brand

ggsave(
  filename = "data_viz/uninsured_by_county.svg",
  scale = 1.5)

# viz 2 by age #### 
# percent uninsured for all income groups in each county 
# grouped by age group
sahie_2019_az %>%
  filter(countyfips != "000",
         racecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  ggplot(mapping = aes(x = reorder(county_name, pctelig), y = pctelig)) +
  geom_bar(fill = "#1E5288", stat = "identity", position = "dodge") +
  facet_wrap(~agecat_labels) +
  geom_errorbar(aes(ymin = (pctelig-pctelig_moe), ymax = (pctelig+pctelig_moe)), color = "#001C48") +
  coord_flip() +
  labs(title = "Percent Uninsured in Arizona Counties Grouped by Age Group",
       subtitle = "2019, Under 65 years, All Races, Both Sexes, All Incomes",
       x = "County", 
       y = "Percent Uninsured",
       caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program") +
  theme_uazcc_brand

ggsave(
  filename = "data_viz/uninsured_by_county_age.svg",
  scale = 1.5)

# viz 3 by sex #### 
# percent uninsured for all income groups in each county 
# grouped by sex group
sahie_2019_az %>%
  filter(countyfips != "000",
         agecat == "0",
         racecat == "0",
         iprcat == "0") %>%
  ggplot(mapping = aes(x = reorder(county_name, pctelig), y = pctelig)) +
  geom_bar(fill = "#1E5288", stat = "identity", position = "dodge") +
  facet_wrap(~sexcat_labels) +
  geom_errorbar(aes(ymin = (pctelig-pctelig_moe), ymax = (pctelig+pctelig_moe)), color = "#001C48") +
  coord_flip() +
  # ylim(c(0,100)) +
  labs(title = "Percent Uninsured in Arizona Counties Grouped by Sex",
       subtitle = "2019, Under 65 years, All Races, All Incomes",
       x = "County", 
       y = "Percent Uninsured",
       caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program") +
  theme_uazcc_brand

ggsave(
  filename = "data_viz/uninsured_by_county_sex.svg",
  scale = 1.5)

# viz 4 by income #### 
# percent uninsured for all income groups in each county 
# grouped by income category
sahie_2019_az %>%
  filter(countyfips != "000",
         agecat == "0",
         racecat == "0",
         sexcat == "0") %>%
  ggplot(mapping = aes(x = reorder(county_name, pctelig), y = pctelig)) +
  geom_bar(fill = "#1E5288", stat = "identity", position = "dodge") +
  facet_wrap(~iprcat_labels) +
  geom_errorbar(aes(ymin = (pctelig-pctelig_moe), ymax = (pctelig+pctelig_moe)), color = "#001C48") +
  coord_flip() +
  # ylim(c(0,100)) +
  labs(title = "Percent Uninsured in Arizona Counties Grouped by Income Category",
       subtitle = "2019, Under 65 years, All Races, Both Sexes",
       x = "County", 
       y = "Percent Uninsured",
       caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program") +
  theme_uazcc_brand

ggsave(
  filename = "data_viz/uninsured_by_county_income.svg",
  scale = 1.5)

