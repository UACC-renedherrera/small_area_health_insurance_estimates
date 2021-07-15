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
library(sf)
library(ggthemes)
library(RColorBrewer)

# list of catchment counties
uazcc_catchment_counties <- c(
  "Cochise",
  "Pima",
  "Pinal",
  "Santa Cruz",
  "Yuma"
)

# Primary Color Palette 2
# c("UA Red", "Arizona Blue")
uazcc_primary_palette <- c("#0C234B", "#AB0520")

# Qualitative color palette
# Secondary Color Palette 4
# c("Leaf", "River", "Silver", "Mesa")
uazcc_color_palette_4 <- c("#70B865", "#007D84", "#9EABAE", "#A95C42")

# read data #### 
# data frame
sahie_az <- read_rds("data/tidy/sahie_az.rds")

# catchment only 
sahie_az_uazcc <- read_rds("data/tidy/sahie_az.rds") %>%
  filter(uazcc_catchment == "yes")

# spatial
sahie_az_spatial <- read_rds("data/tidy/sahie_az_spatial.rds")

# catchment only spatial 
sahie_az_uazcc_spatial <- read_rds("data/tidy/sahie_az_uazcc_spatial.rds")

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

# catchment only in 2019
sahie_az_uazcc_2019 <- sahie_az_uazcc %>%
  filter(year == "2019",
         countyfips != "000",
         agecat == "0",
         racecat == "0",
         sexcat == "0",
         iprcat == "0"
  )

#### viz 1 by county ####
# percent uninsured for all income groups in each county
sahie_az %>%
  filter(
    year == "2019",
    countyfips != "000",
    agecat == "0",
    racecat == "0",
    sexcat == "0",
    iprcat == "0"
  ) %>%
  ggplot(mapping = aes(x = reorder(county_name, pctelig), y = pctelig)) +
  geom_bar(stat = "identity", mapping = aes(fill = pctelig)) +
  geom_bar(data = sahie_az_uazcc_2019, mapping = aes(x = reorder(county_name, pctelig), y = pctelig), color = "#AB0520", stat = "identity", alpha = 0.01) +
  geom_errorbar(aes(ymin = (pctelig - pctelig_moe), ymax = (pctelig + pctelig_moe)), color = "#001C48") +
  scale_fill_viridis_c() +
  coord_flip() +
  labs(
    title = "Percent Uninsured in Arizona Counties",
    subtitle = "2019, Under 65 years, All Races, Both Sexes, All Incomes",
    x = "County",
    y = "Percent Uninsured",
    fill = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program"
  ) +
  theme_uazcc_brand +
  theme(legend.position = "none")

ggsave(
  filename = "data_viz/uninsured_by_county.svg",
  scale = 1.5
)

# #### viz 1 by county spatial 2019 ####
sahie_az_spatial %>%
  filter(year == "2019",
    countyfips != "000",
    agecat == "0",
    racecat == "0",
    sexcat == "0",
    iprcat == "0"
  ) %>%
  ggplot() +
  geom_sf(mapping = aes(fill = pctelig), color = "white") +
  geom_sf(data = sahie_az_uazcc_spatial, mapping = aes(fill = pctelig), color = "#AB0520", alpha = 0.01) +
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
  filename = "data_viz/uninsured_by_county_spatial_2019.svg",
  scale = 1.5
)

# #### viz 1 by county spatial 2018 ####
sahie_az_spatial %>%
  filter(year == "2018",
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
    subtitle = "2018, Under 65 years, All Races, Both Sexes, All Incomes",
    x = "County",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2018 Small Area Health Insurance Estimates (SAHIE) program"
  ) +
  theme_uazcc_brand_spatial

ggsave(
  filename = "data_viz/uninsured_by_county_spatial_2018.svg",
  scale = 1.5
)

# #### viz 1 by county spatial 2017 ####
sahie_az_spatial %>%
  filter(year == "2017",
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
    subtitle = "2017, Under 65 years, All Races, Both Sexes, All Incomes",
    x = "County",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2017 Small Area Health Insurance Estimates (SAHIE) program"
  ) +
  theme_uazcc_brand_spatial

ggsave(
  filename = "data_viz/uninsured_by_county_spatial_2017.svg",
  scale = 1.5
)

# #### viz 1 by county spatial 2016 ####
sahie_az_spatial %>%
  filter(year == "2016",
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
    subtitle = "2016, Under 65 years, All Races, Both Sexes, All Incomes",
    x = "County",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2016 Small Area Health Insurance Estimates (SAHIE) program"
  ) +
  theme_uazcc_brand_spatial

ggsave(
  filename = "data_viz/uninsured_by_county_spatial_2016.svg",
  scale = 1.5
)

# #### viz 1 by county spatial 2015 ####
sahie_az_spatial %>%
  filter(year == "2015",
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
    subtitle = "2015, Under 65 years, All Races, Both Sexes, All Incomes",
    x = "County",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2015 Small Area Health Insurance Estimates (SAHIE) program"
  ) +
  theme_uazcc_brand_spatial

ggsave(
  filename = "data_viz/uninsured_by_county_spatial_2015.svg",
  scale = 1.5
)

# catchment only in 2019
sahie_az_uazcc_2019 <- sahie_az_uazcc %>%
  filter(year == "2019",
         countyfips != "000",
         racecat == "0",
         sexcat == "0",
         iprcat == "0"
  )

# viz 2 by age ####
# percent uninsured for all income groups in each county
# grouped by age group
sahie_az %>%
  filter(year == "2019",
    countyfips != "000",
    racecat == "0",
    sexcat == "0",
    iprcat == "0"
  ) %>%
  ggplot(mapping = aes(x = reorder(county_name, pctelig), y = pctelig)) +
  geom_bar(fill = "#1E5288", stat = "identity", position = "dodge") +
  geom_bar(data = sahie_az_uazcc_2019, mapping = aes(x = reorder(county_name, pctelig), y = pctelig), fill = "#AB0520", stat = "identity") +
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

# comparing insurance rates grouped by age group and catchment
sahie_az %>%
  group_by(uazcc_catchment, agecat_labels) %>%
  filter(geocat == "50",
         racecat == "0",
         sexcat == "0",
         iprcat == "0") %>%
  summarise(nui = sum(nui),
            nipr = sum(nipr)) %>%
  mutate(pctui = 100*(nui/nipr)) %>%
  ggplot() +
  geom_bar(mapping = aes(x = agecat_labels, y = pctui, fill = uazcc_catchment), color = "white", position = "dodge", stat = "identity") +
  coord_flip() +
  labs(
    title = "Percent Uninsured in Arizona Counties Grouped by Age Group",
    subtitle = "2019, Under 65 years, All Races, Both Sexes",
    x = "Income Group",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program",
    fill = "UAZCC Catchment"
  ) +
  scale_fill_manual(values = uazcc_primary_palette) +
  theme_uazcc_brand

ggsave(
  filename = "data_viz/uninsured_by_county_age_catch.svg",
  scale = 1.5
)

# catchment only in 2019
sahie_az_uazcc_2019 <- sahie_az_uazcc %>%
  filter(year == "2019",
         countyfips != "000",
         agecat == "0",
         racecat == "0",
         iprcat == "0"
  )

# viz 3 by sex ####
# percent uninsured for all income groups in each county
# grouped by sex group
sahie_az %>%
  filter(year == "2019",
    countyfips != "000",
    agecat == "0",
    racecat == "0",
    iprcat == "0"
  ) %>%
  ggplot(mapping = aes(x = reorder(county_name, pctelig), y = pctelig)) +
  geom_bar(fill = "#1E5288", stat = "identity", position = "dodge") +
  geom_bar(data = sahie_az_uazcc_2019, mapping = aes(x = reorder(county_name, pctelig), y = pctelig), fill = "#AB0520", stat = "identity") +
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

# comparing insurance rates grouped by sex and catchment
sahie_az %>%
  group_by(uazcc_catchment, sexcat_labels) %>%
  filter(geocat == "50",
         agecat == "0",
         racecat == "0",
         iprcat == "0") %>%
  summarise(nui = sum(nui),
            nipr = sum(nipr)) %>%
  mutate(pctui = 100*(nui/nipr)) %>%
  ggplot() +
  geom_bar(mapping = aes(x = sexcat_labels, y = pctui, fill = uazcc_catchment), position = "dodge", stat = "identity") +
  coord_flip() +
  labs(
    title = "Percent Uninsured in Arizona Counties Grouped by Sex",
    subtitle = "2019, Under 65 years, All Races, Both Sexes",
    x = "Income Group",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program",
    fill = "UAZCC Catchment"
  ) +
  scale_fill_manual(values = uazcc_primary_palette) +
  theme_uazcc_brand

ggsave(
  filename = "data_viz/uninsured_by_county_sex_catch.svg",
  scale = 1.5
)

# catchment only in 2019
sahie_az_uazcc_2019 <- sahie_az_uazcc %>%
  filter(year == "2019",
         countyfips != "000",
         agecat == "0",
         racecat == "0",
         sexcat == "0"
  )

# viz 4 by income ####
# percent uninsured for all income groups in each county
# grouped by income category
sahie_az %>%
  filter(year == "2019",
    countyfips != "000",
    agecat == "0",
    racecat == "0",
    sexcat == "0"
  ) %>%
  ggplot(mapping = aes(x = reorder(county_name, pctelig), y = pctelig)) +
  geom_bar(fill = "#1E5288", stat = "identity", position = "dodge") +
  geom_bar(data = sahie_az_uazcc_2019, mapping = aes(x = reorder(county_name, pctelig), y = pctelig), fill = "#AB0520", stat = "identity") +
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

# comparing insurance rates grouped by income and catchment
sahie_az %>%
  group_by(uazcc_catchment, iprcat_labels) %>%
  filter(geocat == "50",
         agecat == "0",
         racecat == "0",
         sexcat == "0") %>%
  summarise(nui = sum(nui),
            nipr = sum(nipr)) %>%
  mutate(pctui = 100*(nui/nipr)) %>%
  ggplot() +
  geom_bar(mapping = aes(x = iprcat_labels, y = pctui, fill = uazcc_catchment), position = "dodge", stat = "identity") +
  coord_flip() +
  labs(
    title = "Percent Uninsured in Arizona Counties Grouped by Income Category",
    subtitle = "2019, Under 65 years, All Races, Both Sexes",
    x = "Income Group",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program",
    fill = "UAZCC Catchment"
  ) +
  scale_fill_manual(values = uazcc_primary_palette) +
  theme_uazcc_brand

ggsave(
  filename = "data_viz/uninsured_by_county_income_catch.svg",
  scale = 1.5
)

# catchment only in 2019
sahie_az_uazcc_2019 <- sahie_az_uazcc %>%
  filter(year == "2019",
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
  mutate(pct_ui = (nui / nipr) * 100)

# viz 5 by catchment ####
# percent uninsured for all income groups in each county
# grouped by catchment
sahie_az %>%
  filter(year == "2019",
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
  geom_bar(data = sahie_az_uazcc_2019, mapping = aes(x = reorder(uazcc_catchment, pct_ui), y = pct_ui), fill = "#AB0520", stat = "identity") +
  coord_flip() +
  labs(
    title = "Percent Uninsured in Arizona Counties",
    subtitle = "2019, Under 65 years, All Races, Both Sexes, Aggregate values",
    x = "UAZCC Catchment",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program"
  ) +
  theme_uazcc_brand

ggsave(
  filename = "data_viz/uninsured_by_county_catchment_income.svg",
  scale = 1.5
)

# viz 6 by catchment over time ####
# percent uninsured for all income groups in each county over time 
# grouped by catchment
sahie_az %>%
  filter(countyfips != "000",
         agecat == "0",
         racecat == "0",
         sexcat == "0",
         iprcat == "0"
  ) %>%
  group_by(uazcc_catchment, year) %>%
  summarise(
    nui = sum(nui),
    nipr = sum(nipr)
  ) %>%
  mutate(pct_ui = (nui / nipr) * 100) %>%
  ggplot() +
  geom_line(mapping = aes(x = year, y = pct_ui, color = uazcc_catchment), size = 2) +
  ylim(c(0,15)) +
  labs(
    title = "Percent Uninsured in Arizona Counties",
    subtitle = "Under 65 years, All Races, Both Sexes, Aggregate values",
    x = "Year",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program",
    color = "UAZCC Catchment"
  ) +
  scale_color_manual(values = uazcc_primary_palette) +
  theme_uazcc_brand

ggsave(
  filename = "data_viz/uninsured_by_county_catchment_time.svg",
  scale = 1.5
)

# viz 7 az by race ####
# percent uninsured for all income groups in each county
# grouped by race and sex 
sahie_az %>%
  filter(year == "2019",
         countyfips == "000",
         iprcat == "0",
         agecat == "0"
  ) %>%
  ggplot(mapping = aes(x = reorder(racecat_labels, pctelig), y = pctelig)) +
  geom_bar(fill = "#1E5288", stat = "identity", position = "dodge") +
  facet_wrap(~sexcat_labels) +
  geom_errorbar(aes(ymin = (pctelig - pctelig_moe), ymax = (pctelig + pctelig_moe)), color = "#001C48") +
  coord_flip() +
  labs(
    title = "Percent Uninsured in Arizona by Race",
    subtitle = "2019, Under 65 years, All Incomes, All Counties",
    x = "Race",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program"
  ) +
  theme_uazcc_brand

ggsave(
  filename = "data_viz/uninsured_by_race_sex.svg",
  scale = 1.5
)

# viz 8 catchment by income ####
sahie_az_uazcc %>%
  filter(year == "2019",
         sexcat == "0",
         agecat == "0") %>%
  group_by(county_name) %>%
  ggplot(mapping = aes(x = reorder(county_name, pctelig), y = pctelig)) +
  geom_bar(fill = "#1E5288", stat = "identity", position = "dodge") +
  facet_wrap(~iprcat_labels) +
  geom_errorbar(aes(ymin = (pctelig - pctelig_moe), ymax = (pctelig + pctelig_moe)), color = "#001C48") +
  coord_flip() +
  labs(
    title = "Percent Uninsured in Arizona UAZCC Catchment Counties by Income Category",
    subtitle = "2019, Under 65 years, All Races, Both Sexes",
    x = "County",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program"
  ) +
  theme_uazcc_brand

# viz 9 catchment by age ####
sahie_az_uazcc %>%
  filter(year == "2019",
         sexcat == "0",
         iprcat == "0") %>%
  group_by(county_name) %>%
  ggplot(mapping = aes(x = reorder(county_name, pctelig), y = pctelig)) +
  geom_bar(fill = "#1E5288", stat = "identity", position = "dodge") +
  facet_wrap(~agecat_labels) +
  geom_errorbar(aes(ymin = (pctelig - pctelig_moe), ymax = (pctelig + pctelig_moe)), color = "#001C48") +
  coord_flip() +
  labs(
    title = "Percent Uninsured in Arizona UAZCC Catchment Counties by Age Group",
    subtitle = "2019, Under 65 years, All Races, Both Sexes, All income levels",
    x = "County",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program"
  ) +
  theme_uazcc_brand

# viz 10 catchment by age & sex ####
sahie_az_uazcc %>%
  filter(year == "2019",
         iprcat == "0") %>%
  group_by(county_name) %>%
  ggplot(mapping = aes(x = reorder(county_name, pctelig), y = pctelig, fill = sexcat_labels)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~agecat_labels) +
  coord_flip() +
  labs(
    title = "Percent Uninsured in Arizona UAZCC Catchment Counties by Age Group",
    subtitle = "2019, Under 65 years, All Races, Both Sexes, All income levels",
    x = "County",
    y = "Percent Uninsured",
    caption = "Source: U.S. Census Bureau, 2019 Small Area Health Insurance Estimates (SAHIE) program",
    fill = "Sex"
  ) +
  theme_uazcc_brand +
  scale_fill_brewer(palette = "Set1")



