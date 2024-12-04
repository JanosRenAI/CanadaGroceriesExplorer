#### Preamble ####
# Purpose: Tests the structure and validity of the simulated olive oil dataset.
# Author: Xuanang Ren
# Date: 2 December 2024
# Contact: ang.ren@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - The `arrow` and `dplyr` packages must be installed and loaded.
# - 00-simulate_data.R must have been run.

#### Workspace setup ####
library(dplyr)
library(arrow)

# Load the simulated data from Parquet
simulate_data <- read_parquet("data/00-simulated_data/simulate_data.parquet")

# Test if the data was successfully loaded
if (exists("simulate_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test data ####

# Check if the dataset has 2000 rows
if (nrow(simulate_data) == 2000) {
  message("Test Passed: The dataset has 2000 rows.")
} else {
  stop("Test Failed: The dataset does not have 2000 rows.")
}

# Check if the dataset has 8 columns
if (ncol(simulate_data) == 8) {
  message("Test Passed: The dataset has 8 columns.")
} else {
  stop("Test Failed: The dataset does not have 8 columns.")
}

# Check if all values in the 'vendor' column are valid
valid_vendors <- c("Loblaws", "Metro", "Walmart")
if (all(simulate_data$vendor %in% valid_vendors)) {
  message("Test Passed: The 'vendor' column contains only valid vendors.")
} else {
  stop("Test Failed: The 'vendor' column contains invalid entries.")
}

# Check if 'current_price' and 'old_price' are numeric and positive
if (all(simulate_data$current_price > 0) & is.numeric(simulate_data$current_price) & 
    all(simulate_data$old_price > 0) & is.numeric(simulate_data$old_price)) {
  message("Test Passed: The 'current_price' and 'old_price' columns are numeric and positive.")
} else {
  stop("Test Failed: The 'current_price' or 'old_price' columns contain invalid values.")
}

# Check if 'product_name' contains only predefined product names
valid_products <- c(
  "Extra Virgin Olive Oil 500ml", 
  "Pure Olive Oil 1L", 
  "Organic Olive Oil 750ml", 
  "Premium Olive Oil 1L", 
  "Classic Olive Oil 2L"
)
if (all(simulate_data$product_name %in% valid_products)) {
  message("Test Passed: The 'product_name' column contains only valid product names.")
} else {
  stop("Test Failed: The 'product_name' column contains invalid entries.")
}

# Check if 'brand' column is not empty
if (all(simulate_data$brand != "")) {
  message("Test Passed: The 'brand' column does not contain empty strings.")
} else {
  stop("Test Failed: The 'brand' column contains empty strings.")
}

# Check if there are no missing values in the dataset
if (all(!is.na(simulate_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if 'month' is a valid two-digit month format
if (all(simulate_data$month %in% sprintf("%02d", 1:12))) {
  message("Test Passed: The 'month' column contains valid month values.")
} else {
  stop("Test Failed: The 'month' column contains invalid values.")
}

# Check if 'price_per_unit' is greater than 0
if (all(simulate_data$price_per_unit > 0)) {
  message("Test Passed: The 'price_per_unit' column values are all greater than 0.")
} else {
  stop("Test Failed: The 'price_per_unit' column contains non-positive values.")
}
