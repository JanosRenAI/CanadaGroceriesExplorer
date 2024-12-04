#### Preamble ####
# Purpose: Simulate data similar to the cleaned olive oil data for testing purposes.
# Author: Xuanang Ren
# Date: 2 December 2024
# Contact: ang.ren@mail.utoronto.ca
# License: MIT
# Pre-requisites: dplyr, lubridate
# Any other information needed? Ensure that libraries are installed before running.

#### Workspace setup ####
library(dplyr)
library(lubridate)
library(stringr)
library(readr)
library(arrow)

#### Simulate data ####
set.seed(123)  # For reproducibility

# Parameters
n <- 2000  # Number of rows to simulate
vendors <- c("Loblaws", "Metro", "Walmart")
brands <- c("BrandA", "BrandB", "BrandC", "BrandD", "BrandE")
product_names <- c(
  "Extra Virgin Olive Oil 500ml", 
  "Pure Olive Oil 1L", 
  "Organic Olive Oil 750ml", 
  "Premium Olive Oil 1L", 
  "Classic Olive Oil 2L"
)

# Generate random data
simulate_data <- tibble(
  nowtime = sample(seq(
    from = as.POSIXct("2024-01-01 00:00:00", tz = "UTC"),
    to = as.POSIXct("2024-12-31 23:59:59", tz = "UTC"),
    by = "hour"
  ), size = n, replace = TRUE),
  current_price = round(runif(n, min = 5, max = 40), 2),
  old_price = round(current_price * runif(n, min = 0.9, max = 1.5), 2),
  price_per_unit = round(current_price / sample(c(0.5, 1, 1.5, 2), size = n, replace = TRUE), 2),
  product_name = sample(product_names, size = n, replace = TRUE),
  brand = sample(brands, size = n, replace = TRUE),
  vendor = sample(vendors, size = n, replace = TRUE)
) %>%
  # Add 'month' column based on 'nowtime'
  mutate(
    month = format(nowtime, "%m")
  )

#### Save simulated data ####
# Save as CSV for further analysis
write_csv(simulate_data, "data/00-simulated_data/simulate_data.csv")

# Save as Parquet for efficient storage and retrieval
write_parquet(simulate_data, "data/00-simulated_data/simulate_data.parquet")

