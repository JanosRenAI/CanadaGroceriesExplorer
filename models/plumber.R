library(plumber)
library(rstanarm)
library(tidyverse)

# Load the model
model <- readRDS("first_model.rds")

# Define the model version
version_number <- "0.0.1"

# Define the variables
variables <- list(
  old_price = "The previous price of the product, numeric value.",
  brand = "The brand of the product, categorical",
  vendor = "The vendor identifier, categorical - Metro or Walmart",
  month = "The month of the year, numeric (7 to 12)."
)

#* @param old_price 
#* @param brand
#* @param vendor 
#* @param month 
#* @get /predict_price
predict_price <- function(old_price = 1.75, 
                          brand = "Aurora", 
                          vendor = "Metro", 
                          month = 7) {
  # Convert inputs to appropriate types
  old_price <- as.numeric(old_price)
  brand <- as.character(brand)
  vendor <- as.character(vendor)
  month <- as.integer(month)
  
  # Prepare the payload as a data frame
  payload <- data.frame(
    old_price = old_price,
    brand = brand,
    vendor = vendor,
    month = month
  )
  
  # Extract posterior samples
  posterior_samples <- as.matrix(model)
  
  # Define the generative process for prediction
  beta_old_price <- posterior_samples[, "old_price"]
  alpha <- posterior_samples[, "(Intercept)"]
  
  # Get brand coefficient name
  brand_col <- paste0("brand", brand)
  beta_brand <- posterior_samples[, brand_col]
  
  # Get vendor coefficient name
  vendor_col <- paste0("vendor", vendor)
  beta_vendor <- posterior_samples[, vendor_col]
  
  # Get month coefficient name
  month_col <- paste0("month", sprintf("%02d", month))
  beta_month <- posterior_samples[, month_col]
  
  # Compute the predicted values
  predicted_values <- alpha +
    beta_old_price * payload$old_price +
    beta_brand +  # Brand effect is direct since it's a categorical variable
    beta_vendor +  # Vendor effect is direct
    beta_month    # Month effect is direct
  
  # Calculate mean prediction
  mean_prediction <- mean(predicted_values)
  
  # Store results
  result <- list(
    "estimated_price" = mean_prediction
  )
  
  return(result)
}