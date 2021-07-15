# Small Area Health Insurance Estimates (SAHIE)

2008 - 2019 Small Area Health Insurance Estimates (SAHIE) using the American Community Survey (ACS)

# Start Here

The [data_tidy.R](scripts/data_tidy.R) script will:

1. download SAHIE datasets for years 2015-2019
2. unzip them to folders
3. read them to your R environment
4. and bind / join each of the datasets to one single dataset
5. subset a new dataset for the state of Arizona
6. save the large dataset to disk as an 323.9MB RDS file
7. save the AZ dataset to disk as an 2MB RDS file

Now you're ready to explore the data in the [data_processing.R](scripts/data_processing.R) and [data_viz.R](scripts/data_viz.R).

See the dashboard produced with this data: https://rpubs.com/UAZCC_Rene/sahie_az 

# Narrative

In this project I tidy, explore, and process the 2019 data released by the Small Area Health Insurance Estimates (SAHIE) program. Ultimately, I'm trying to identify which, if any, inequities or disparities exist among Arizona populations; it's a question about explaining access to health care. This data set provides summary (model-based estimates of health insurance coverage for counties and states) information for the following variables:

- **Age groups**: Under 65 years, 18-64 years, 21-64 years, 40-64 years, 50-64 years, under 19 years
- **Sex groups**: Both sexes, male only, female only
- **Income groups**: All incomes; <=200%, <=250%, <=138%, <=400%, 138-400% of poverty
- **Age**: Estimates for the under 19 years group are available for just the six income categories listed above
- **Race**: For states only: White alone, not Hispanic; Black alone, not Hispanic; and Hispanic (any race)

Once you review the data for Arizona you may notice that the population with the lowest rates of health insurance coverage is Hispanic men, between 21 and 64 years of age, at or below 138% of the federal poverty level. While the population with the highest percentage of health insurance coverage is Black (not Hispanic) women between 50 and 64 years of age.

## Counties with the Lowest and Highest Percentage of Coverage

The county with the lowest percentage of health insurance coverage is La Paz County. The county with the highest percentage of health insurance coverage is Greenlee County.

## Age Groups

The age group with the lowest percentage of coverage is the population age 18 to 64 years.

## Race

The race group with the lowest percentage of coverage is the Hispanic (of any race) population.

## Sex

Of the two sexes reported, the population with the lowest percentage of coverage is male.

## Income

The income category with the lowest percentage of coverage is for people at or below 200% of the federal poverty level.

# References

- US Census Bureau. 2021. “Small Area Health Insurance Estimates (SAHIE) Program.” The United States Census Bureau. March 25, 2021. https://www.census.gov/programs-surveys/sahie.html.
- US Centers for Medicare & Medicaid Services. n.d. “Federal Poverty Level (FPL) - HealthCare.Gov Glossary.” HealthCare.Gov. Accessed July 15, 2021. https://www.healthcare.gov/glossary/federal-poverty-level-FPL/.
