#### Preamble ####
# Purpose: 
# Author: Xuanang Ren
# Date: 2 December 2024
# Contact: ang.ren@mail.utoronto.ca
# License: MIT
# Pre-requisites: rstanarm, tidyverse, arrow, lubridate
# Any other information needed?

#### Workspace setup ####
library(rstanarm)
library(tidyverse)
library(arrow)
library(lubridate)
library(gridExtra)

# Load the cleaned data from the parquet file
clean_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

# Generate the plot
ggplot(clean_data %>%group_by(month) %>% summarise(AverageCurrentPrice = mean(current_price, na.rm=TRUE)), aes(x=month, y=AverageCurrentPrice)) +
  geom_line(aes(group=1), color="blue", size=1) +  # Line connecting average prices
  geom_point(color="darkblue") +  # Points for each month's average price
  labs(title="Average Current Price Per Month",
       x="Month",
       y="Average Current Price") +
  theme_minimal()



# Plotting price differences by month and vendor
ggplot(clean_data, aes(x = month, y = price_diff, fill = vendor)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Monthly Price Differences by Vendor",
       x = "Month",
       y = "Price Difference",
       fill = "Vendor") +
  theme_minimal()



#### Plot 1: Old vs. Current Prices ####
g1 <- ggplot(clean_data, aes(x = old_price, y = current_price)) +
  geom_point(aes(color = brand), alpha = 0.6) +  # Use color to differentiate by brand
  geom_smooth(method = "lm", color = "skyblue", se = FALSE) +
  labs(title = "Relationship Between Old and Current Prices",
       x = "Old Price ($)",
       y = "Current Price ($)") +
  theme_minimal()

g2 <- ggplot(clean_data, aes(x = old_price, y = current_price, color = vendor)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", aes(group = 1), color = "skyblue", se = FALSE) + 
  labs(title = "Current vs. Old Prices by Vendor",
       x = "Old Price",
       y = "Current Price",
       color = "Vendor") +
  theme_minimal()

grid.arrange(g1, g2, ncol=1)


#### Plot 2: Product Name vs. Current Price ####

ggplot(clean_data, aes(x = fct_reorder(product_name, current_price), y = current_price)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Current Prices Across Different Products",
       x = "Product Name",
       y = "Current Price ($)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))  # Rotate x-axis labels for readability


#### Plot 3: Brand vs. Current Price ####
ggplot(clean_data, aes(x = brand, y = current_price, fill = brand)) +
  geom_boxplot() +
  labs(title = "Price Distribution by Brand",
       x = "Brand",
       y = "Current Price ($)") +
  theme_minimal()


#### Plot 4: Vendor vs. Current Price ####
ggplot(clean_data, aes(x = vendor, y = current_price, fill = vendor)) +
  geom_boxplot() +
  labs(title = "Current Prices by Vendor",
       x = "Vendor",
       y = "Current Price ($)") +
  theme_minimal()
