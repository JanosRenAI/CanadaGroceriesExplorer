#### Preamble ####
# Purpose: Test the integrity and structure of the cleaned olive oil data stored in Parquet format.
# Author: Xuanang Ren
# Date: 2 December 2024
# Contact: ang.ren@mail.utoronto.ca
# License: MIT
# Pre-requisites: dplyr, arrow, testthat
# Any other information needed? Ensure that 'arrow' library is installed for Parquet file handling.

#### Workspace setup ####
library(dplyr)
library(arrow)
library(testthat)

#### Load cleaned data from Parquet ####
clean_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

#### Test data ####
# Test that the dataset has expected number of rows
test_that("dataset has expected number of rows", {
  expect_equal(nrow(clean_data), 3061)  # Adjust the expected number as needed
})

# Test that the dataset has 6 columns (as per the cleaning script)
test_that("dataset has 6 columns", {
  expect_equal(ncol(clean_data), 6)
})

# Test that the 'month' column is character type
test_that("'month' is character", {
  expect_type(clean_data$month, "character")
})

# Test that the 'current_price' and 'old_price' columns are numeric type
test_that("price columns are numeric", {
  expect_type(clean_data$current_price, "double")
  expect_type(clean_data$old_price, "double")
})

# Test that there are no missing values in critical columns
test_that("no missing values in price and product name columns", {
  expect_true(all(!is.na(clean_data$current_price) & !is.na(clean_data$old_price) & !is.na(clean_data$product_name)))
})

# Test that 'product_name' contains "Olive Oil"
test_that("'product_name' contains 'Olive Oil'", {
  expect_true(all(grepl("Olive Oil", clean_data$product_name)))
})

# Test that 'vendor' only includes 'Loblaws', 'Metro', and 'Walmart'
valid_vendors <- c("Loblaws", "Metro", "Walmart")
test_that("'vendor' column contains valid vendors", {
  expect_true(all(clean_data$vendor %in% valid_vendors))
})

# Test that there are no incorrect or outlier values in 'current_price' or 'old_price' columns
test_that("no incorrect prices", {
  expect_true(all(clean_data$current_price > 0 & clean_data$old_price > 0))
})

# Test that price values are within a reasonable range
test_that("prices are within expected ranges", {
  expect_true(all(clean_data$current_price >= 0 & clean_data$current_price <= 100))
  expect_true(all(clean_data$old_price >= 0 & clean_data$old_price <= 100))
})

# Test that 'month' values are correctly formatted (MM)
test_that("month values are correctly formatted", {
  expect_true(all(nchar(clean_data$month) == 2))
})

