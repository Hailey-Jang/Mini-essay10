#### Workspace setup ####
library(readr)
library(dplyr)
library(MASS)

# Load the dataset
file_path <- "data/raw_data/raw_data.csv"
data <- read_csv(file_path, skip = 1, col_names = c("Year", "Geography", "Type_of_Care", "Sex", "Average_Monthly_Number"))

# Check the structure of the data
str(data)

# Preprocess the data: You might need to convert factors, handle missing values, etc.
# Ensure the Year column is appropriately formatted (extract year if necessary)
data$Year <- as.factor(substring(data$Year, 1, 4))

# Convert 'Type_of_Care' and 'Sex' to factor type as they are categorical variables
data$Type_of_Care <- as.factor(data$Type_of_Care)
data$Sex <- as.factor(data$Sex)

# Convert the target variable to numeric
data$Average_Monthly_Number <- as.numeric(data$Average_Monthly_Number)

# Fit the Negative Binomial Regression model
first_model <- glm.nb(Average_Monthly_Number ~ Year + Type_of_Care + Sex, data = data)

# Output the summary of the model
summary(first_model)

#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)


