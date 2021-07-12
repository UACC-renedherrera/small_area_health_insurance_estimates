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
# data frame
sahie_2019_az <- read_rds("data/tidy/sahie_2019_az.rds")

# spatial
sahie_2019_az_spatial <- read_rds("data/tidy/sahie_2019_az_spatial.rds")

# set theme ####
# set consistent theme for graphics & data visualizations
theme_uazcc_brand <- theme_clean() +
  theme(
    text = element_text(
      family = "sans",
      face = "bold",
      color = "#001C48",
      size = 12
    ),
    panel.background = element_rect(fill = "white"),
    panel.grid = element_line(color = "#1E5288"),
    plot.background = element_rect(fill = "#EcE9EB"),
    aspect.ratio = 2 / 3,
    legend.background = element_rect(fill = "white"),
    legend.position = "bottom",
    plot.caption = element_text(size = 10),
    plot.subtitle = element_text(size = 14),
    plot.title = element_text(size = 16),
    strip.background = element_rect(fill = "#EcE9EB")
  )

# spatial
theme_uazcc_brand_spatial <- theme_map() +
  theme(
    text = element_text(
      family = "sans",
      face = "bold",
      color = "#001C48",
      size = 12
    ),
    # panel.background = element_rect(fill = "white"),
    # panel.grid = element_line(color = "#1E5288"),
    # plot.background = element_rect(fill = "#EcE9EB"),
    # legend.background = element_rect(fill = "white"),
    legend.position = "right",
    plot.caption = element_text(size = 10),
    plot.subtitle = element_text(size = 14),
    plot.title = element_text(size = 16),
    strip.background = element_rect(fill = "#EcE9EB")
  )

#### viz 1 by county ####
# percent uninsured for all income groups in each county
sahie_2019_az %>%
  filter(
    countyfips != "000",
    agecat == "0",
    racecat == "0",
    sexcat == "0",
    iprcat == "0"
  ) %>%
  ggplot(mapping = aes(x = reorder(county_name, pctelig), y = pctelig)) +
  geom_bar(fill = "#1E5288", stat = "identity") +
  geom_bar(color = uazcc_catchment_counties, stat = "identity") +
  geom_errorbar(aes(ymin = (pctelig - pctelig_moe), ymax = (pctelig + pctelig_moe)), color = "#001C48") +
  coord_flip() +
  # ylim(c(0,100)) +
  labs(
    title = "Percent Uninsured in Arizona Counties",
    subtitle = "2019, Under 65 years, All Races, Both Sexes, All Incomes",
    x = "County",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program"
  ) +
  theme_uazcc_brand

ggsave(
  filename = "data_viz/uninsured_by_county.svg",
  scale = 1.5
)

# spatial
sahie_2019_az_spatial %>%
  filter(
    countyfips != "000",
    agecat == "0",
    racecat == "0",
    sexcat == "0",
    iprcat == "0"
  ) %>%
  ggplot() +
  geom_sf(mapping = aes(fill = pctelig, color = pctelig), alpha = 0.9) +
  scale_color_viridis_c("Percent uninsured") +
  scale_fill_viridis_c("Percent uninsured") +
  geom_sf_label(mapping = aes(label = name), alpha = 0.6) +
  labs(
    title = "Percent Uninsured in Arizona Counties",
    subtitle = "2019, Under 65 years, All Races, Both Sexes, All Incomes",
    x = "County",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program"
  ) +
  theme_uazcc_brand_spatial

ggsave(
  filename = "data_viz/uninsured_by_county_spatial.svg",
  scale = 1.5
)


# viz 2 by age ####
# percent uninsured for all income groups in each county
# grouped by age group
sahie_2019_az %>%
  filter(
    countyfips != "000",
    racecat == "0",
    sexcat == "0",
    iprcat == "0"
  ) %>%
  ggplot(mapping = aes(x = reorder(county_name, pctelig), y = pctelig)) +
  geom_bar(fill = "#1E5288", stat = "identity", position = "dodge") +
  facet_wrap(~agecat_labels) +
  geom_errorbar(aes(ymin = (pctelig - pctelig_moe), ymax = (pctelig + pctelig_moe)), color = "#001C48") +
  coord_flip() +
  labs(
    title = "Percent Uninsured in Arizona Counties Grouped by Age Group",
    subtitle = "2019, Under 65 years, All Races, Both Sexes, All Incomes",
    x = "County",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program"
  ) +
  theme_uazcc_brand

ggsave(
  filename = "data_viz/uninsured_by_county_age.svg",
  scale = 1.5
)

# viz 3 by sex ####
# percent uninsured for all income groups in each county
# grouped by sex group
sahie_2019_az %>%
  filter(
    countyfips != "000",
    agecat == "0",
    racecat == "0",
    iprcat == "0"
  ) %>%
  ggplot(mapping = aes(x = reorder(county_name, pctelig), y = pctelig)) +
  geom_bar(fill = "#1E5288", stat = "identity", position = "dodge") +
  facet_wrap(~sexcat_labels) +
  geom_errorbar(aes(ymin = (pctelig - pctelig_moe), ymax = (pctelig + pctelig_moe)), color = "#001C48") +
  coord_flip() +
  # ylim(c(0,100)) +
  labs(
    title = "Percent Uninsured in Arizona Counties Grouped by Sex",
    subtitle = "2019, Under 65 years, All Races, All Incomes",
    x = "County",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program"
  ) +
  theme_uazcc_brand

ggsave(
  filename = "data_viz/uninsured_by_county_sex.svg",
  scale = 1.5
)

# viz 4 by income ####
# percent uninsured for all income groups in each county
# grouped by income category
sahie_2019_az %>%
  filter(
    countyfips != "000",
    agecat == "0",
    racecat == "0",
    sexcat == "0"
  ) %>%
  ggplot(mapping = aes(x = reorder(county_name, pctelig), y = pctelig)) +
  geom_bar(fill = "#1E5288", stat = "identity", position = "dodge") +
  facet_wrap(~iprcat_labels) +
  geom_errorbar(aes(ymin = (pctelig - pctelig_moe), ymax = (pctelig + pctelig_moe)), color = "#001C48") +
  coord_flip() +
  # ylim(c(0,100)) +
  labs(
    title = "Percent Uninsured in Arizona Counties Grouped by Income Category",
    subtitle = "2019, Under 65 years, All Races, Both Sexes",
    x = "County",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program"
  ) +
  theme_uazcc_brand

ggsave(
  filename = "data_viz/uninsured_by_county_income.svg",
  scale = 1.5
)

# viz 5 by catchment ####
# percent uninsured for all income groups in each county
# grouped by catchment
sahie_2019_az %>%
  filter(
    countyfips != "000",
    agecat == "0",
    racecat == "0",
    sexcat == "0",
    iprcat == "0"
  ) %>%
  group_by(uazcc_catchment) %>%
  summarise(
    nui = sum(nui),
    nipr = sum(nipr)
  ) %>%
  mutate(pct_ui = (nui / nipr) * 100) %>%
  ggplot(mapping = aes(x = reorder(uazcc_catchment, pct_ui), y = pct_ui)) +
  geom_bar(fill = "#1E5288", stat = "identity", position = "dodge") +
  coord_flip() +
  ylim(c(0, 100)) +
  labs(
    title = "Percent Uninsured in Arizona Counties",
    subtitle = "2019, Under 65 years, All Races, Both Sexes, Aggregate values",
    x = "UAZCC Catchment",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program"
  ) +
  theme_uazcc_brand

ggsave(
  filename = "data_viz/uninsured_by_county_income.svg",
  scale = 1.5
)
