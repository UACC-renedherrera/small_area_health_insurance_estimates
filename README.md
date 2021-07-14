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

Now you're ready to explore the data in the [data_processing.R](scripts/data_processing.R) and [data_viz.R](scripts/data_viz.R)
