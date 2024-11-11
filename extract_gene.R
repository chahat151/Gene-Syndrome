# Function to check and install 'readxl' package if not installed
if (!requireNamespace("readxl", quietly = TRUE)) {
  install.packages("readxl")
}

# Function to check and install 'dplyr' package if not installed
if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}

# Function to check and install 'writexl' package if not installed
if (!requireNamespace("writexl", quietly = TRUE)) {
  install.packages("writexl")
}


library(readxl)
library(dplyr)
library(writexl)

# Load the Excel file
file_path <- "nup170_gene_strain_coordinates.xlsx"
data <- read_excel(file_path)

# Function to filter and export based on inputs
filter_and_export <- function(gene_input = NULL, strain_input = NULL, output_path = "filtered_data.xlsx") {
    # Convert empty strings to NULL
  if (gene_input == "") gene_input <- NULL
  if (strain_input == "") strain_input <- NULL
  filtered_data <- data
  
  # Case 1: If gene is provided and strain is NULL
  if (!is.null(gene_input) && is.null(strain_input)) {
    filtered_data <- filtered_data %>% filter(Gene == gene_input)
  
  # Case 2: If strain is provided and gene is NULL
  } else if (is.null(gene_input) && !is.null(strain_input)) {
    filtered_data <- filtered_data %>% filter(Strain == strain_input)
  
  # Case 3: If both gene and strain are provided
  } else if (!is.null(gene_input) && !is.null(strain_input)) {
    filtered_data <- filtered_data %>% filter(Gene == gene_input & Strain == strain_input)
  }
  
  # Export filtered data to an Excel file
  write_xlsx(filtered_data, output_path)
}

# Usage example
filter_and_export(gene_input = "cac", strain_input = "nop4", output_path = "yel_sir4.xlsx")
