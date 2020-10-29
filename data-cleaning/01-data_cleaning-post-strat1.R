#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Rohan Alexander and Sam Caetano [CHANGE THIS TO YOUR NAME!!!!]
# Data: 22 October 2020
# Contact: rohan.alexander@utoronto.ca [PROBABLY CHANGE THIS ALSO!!!!]
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)

#LABIBS WD
#WD = "/Users/labibchowdhury/coursework/STA304/ps3/US-Presidential-Election-2020-Popular-Vote-Prediction"

#ERICS WD
WD = "~/Library/Mobile Documents/com~apple~CloudDocs/University/5th Year (2020-2021)/STA304/Problem Set 3/US-Presidential-Election-2020-Popular-Vote-Prediction"

#LISAS WD
#WD =

#SAKSHAMS WD
#WD =

# Read in the raw data.
setwd(WD)
raw_data <- read_dta("inputs/usa_00002.dta.gz")


# Add the labels
raw_data <- labelled::to_factor(raw_data)

# Just keep some variables that may be of interest (change 
# this depending on your interests)
reduced_data <- 
  raw_data %>% 
  select(statefip,
         age, 
         race, 
         hhincome)
         

#### What's next? ####

## Here I am only splitting cells by age, but you 
## can use other variables to split by changing
## count(age) to count(age, sex, ....)

reduced_data <- 
  reduced_data %>%
  count(age) %>%
  group_by(age) 

reduced_data <- 
  reduced_data %>% 
  filter(age != "less than 1 year old") %>%
  filter(age != "90 (90+ in 1980 and 1990)")

reduced_data$age <- as.integer(reduced_data$age)

# Saving the census data as a csv file in my
# working directory
write_csv(reduced_data, "outputs/census_data_by_age.csv")



         