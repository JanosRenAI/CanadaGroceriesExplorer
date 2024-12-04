#### Preamble ####
# Purpose: Clean and preprocess raw plane data recorded by two observers and associated product metadata.
# Author: Xuanang Ren
# Date: 2 December 2024
# Contact: ang.ren@mail.utoronto.ca
# License: MIT
# Pre-requisites: Ensure the following libraries are installed: dplyr, arrow, lubridate, readr. 
#                 Verify the existence of the raw data files in the `data/01-raw_data/` directory.

#### Workspace setup ####
library(dplyr)
library(arrow)
library(lubridate)
library(readr)

#### Load raw data ####
raw_data <- read_csv("data/01-raw_data/hammer-4-raw.csv") # Main raw data file
product_data <- read_csv("data/01-raw_data/hammer-4-product.csv") # Product metadata

#### Combine and clean data ####
clean_data <- raw_data %>%
  # Merge raw data with product metadata
  left_join(product_data, by = c("product_id" = "id")) %>%
  
  # Select relevant columns
  select(nowtime, current_price, old_price, price_per_unit, product_name, brand, vendor) %>%
  
  # Filter for olive oil products (edible) and specific vendors
  filter(
    str_detect(product_name, "Olive Oil") & 
      !str_detect(
        product_name, 
        "Infused|Flavored|Blend|Cooking Spray|Hair|Body|Skin|Soap|Cosmetic|Beauty|Extract|Essential|Scent|Aromatherapy|Candles|Gift|Gourmet|Balsamic|Vinegar|Condiment|Dressing|Sauce|Pack|Sample|Mini|Set|Butter|Tuna|Crackers|Cheese|Crackers|Wild|Margarine|Garlic|Bottle|Bread|Sardine|Mayonnaise|Tortas|Fillet|Boulangerie|Rosemary|Tortillas|Mackerel|Pepper"
      ) & 
      vendor %in% c("Loblaws", "Metro", "Walmart")
  ) %>%
  
  # Convert prices to numeric and filter out invalid entries
  mutate(
    current_price = as.numeric(gsub("[^0-9.]", "", current_price)),
    old_price = as.numeric(gsub("[^0-9.]", "", old_price))
  ) %>%
  filter(
    !is.na(current_price) & !is.na(old_price) & !is.na(price_per_unit)
  ) %>%
  
  # Add time and price-related calculations
  mutate(
    nowtime = as.POSIXct(nowtime, tz = "UTC"),
    month = format(nowtime, "%m"),
  ) %>%
  
  # Final selection of columns
  select(month, current_price, old_price, product_name, brand, vendor)

#### Save cleaned data ####
# Save as CSV for further analysis
write_csv(clean_data, "data/02-analysis_data/analysis_data.csv")

# Save as Parquet for efficient storage and retrieval
write_parquet(clean_data, "data/02-analysis_data/analysis_data.parquet")