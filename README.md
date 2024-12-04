# Bayesian Analysis of Olive Oil Pricing in Canadian Markets

## Overview
This repository contains the research project analyzing olive oil pricing dynamics in Canadian grocery retailers using Bayesian linear regression. The study investigates how factors like brand identity, vendor strategies, and seasonal patterns influence olive oil prices, providing insights for retailers and policymakers.

## Research Focus
- Analysis of pricing patterns across major Canadian grocery retailers (Loblaws, Metro, Walmart)
- Investigation of brand influence on pricing strategies
- Examination of seasonal and vendor-specific pricing dynamics
- Application of Bayesian linear regression for predictive modeling

## Statement on LLM Usage
This research utilized ChatGPT for certain aspects of the analysis and writing process. The complete chat history and prompt interactions are documented in `/other/llm_usage/chatgpt.txt`. The use of AI assistance was primarily focused on:
- Structuring the research methodology
- Refining analytical approaches
- Improving clarity in writing
All AI-assisted content was carefully reviewed and validated to ensure accuracy and academic integrity.

## Repository Structure
- `/data`
  - `/raw_data`: Contains original Project Hammer dataset files
  - `/analysis_data`: Processed and cleaned data ready for analysis
- `/model`: Contains fitted Bayesian models and statistical outputs
- `/paper`: Research paper files including the PDF output
- `/scripts`: R scripts for data processing and analysis
  - Data cleaning and transformation scripts
  - Statistical modeling scripts
  - Visualization generation scripts
- `/other`: Supplementary materials
  - Literature references
  - Research notes
  - Model diagnostics
  - ChatGPT interaction logs and documentation
  - AI assistance methodology notes

## Key Findings
- Historical prices serve as strong predictors of current pricing
- Premium brands command significantly higher prices
- Seasonal patterns show notable price variations, particularly during holidays
- Vendor-specific strategies play a significant role in price determination

## Technical Details
- Analysis conducted using R programming language
- Key packages: tidyverse, rstanarm, here, lubridate, arrow
- Bayesian linear regression implemented for predictive modeling
- Visualization tools: ggplot2, gridExtra
- **The model folder contains API for running the Bayesian model**.

## Data Source
Data sourced from Project Hammer (Filipp 2024), providing comprehensive pricing information across Canadian grocery retailers.

## Usage
1. Clone the repository
2. Install required R packages listed in scripts/requirements.R
3. Run data processing scripts in the scripts directory
4. Execute analysis scripts to reproduce results

## Requirements
- R version 4.0 or higher
- RStudio (recommended for ease of use)
The following R packages are required:
- tidyverse (for data manipulation and visualization)
- rstanarm (for Bayesian regression modeling)
- here (for file path management)
- lubridate (for date/time handling)
- arrow (for data storage and retrieval)
- readr (for efficient data reading)
- dplyr (for data manipulation)
- stringr (for string processing)
- gridExtra (for arranging plots)
- knitr (for dynamic report generation)

## Authors
Xuanang Ren

## Acknowledgments
Thanks to Jacob Filipp for providing the Project Hammer dataset and the research community for methodological guidance.
