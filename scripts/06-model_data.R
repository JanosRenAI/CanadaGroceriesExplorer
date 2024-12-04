#### Preamble ####
# Purpose: Model current olive oil prices based on historical prices and other factors
# Author: Xuanang Ren
# Date: 2 December 2024
# Contact: ang.ren@mail.utoronto.ca
# License: MIT
# Pre-requisites: `rstanarm`, `tidyverse` packages must be installed and loaded.


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
clean_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

### Model data ####

# Assuming 'current_price' as dependent variable and 'old_price', 'brand', 'vendor', and 'month' as independent variables.
# Convert categorical variables to factors if not already
analysis_data <- clean_data %>%
  mutate(
    brand = as.factor(brand),
    vendor = as.factor(vendor),
    month = as.factor(month)
  )

### Model 1 ####
# Build a Bayesian linear regression model
first_model <- stan_glm(current_price ~ old_price + brand + vendor + month, data = analysis_data, 
                        family = gaussian, prior = normal(0, 2, autoscale = TRUE))

### Model 2 ####
second_model <- lm(current_price ~ old_price + brand + vendor + month, data = analysis_data)

#### Save model ####
saveRDS(first_model, file = "models/first_model.rds")
saveRDS(second_model, file = "models/second_model.rds")

