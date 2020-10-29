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
# WD = "/Users/labibchowdhury/coursework/STA304/ps3/US-Presidential-Election-2020-Popular-Vote-Prediction"

#ERICS WD
# WD = 

#LISAS WD
WD = "/Users/Lisa/Desktop/PS3"

#SAKSHAMS WD
#WD =

# Read in the raw data.
setwd(WD)
raw_data <- read_dta("inputs/usa_00002.dta.gz")


# Add the labels
raw_data <- labelled::to_factor(raw_data)

# Just keep some variables that may be of interest (change 
# this depending on your interests)
reduced_data <- raw_data %>% 
  select(statefip, age, race, hhincome)

#### What's next? ####

# group HHIncome to matching survey groups
# removed NA (value=9999999)
reduced_data<- reduced_data %>%
  filter(hhincome != 9999999) %>%
  mutate(household_income = ifelse(hhincome <= 14999, "Less than $14,999", 
                            ifelse(hhincome <= 19999, "$15,000 to $19,999", 
                            ifelse(hhincome <= 24999, "$20,000 to $24,999",
                            ifelse(hhincome <= 29999, "$25,000 to $29,999",
                            ifelse(hhincome <= 34999, "$30,000 to $34,999",
                            ifelse(hhincome <= 39999, "$35,000 to $39,999",
                            ifelse(hhincome <= 44999, "$40,000 to $44,999",
                            ifelse(hhincome <= 49999, "$45,000 to $49,999",
                            ifelse(hhincome <= 54999, "$50,000 to $54,999",
                            ifelse(hhincome <= 59999, "$55,000 to $59,999",
                            ifelse(hhincome <= 64999, "$60,000 to $64,999",
                            ifelse(hhincome <= 69999, "$65,000 to $69,999",
                            ifelse(hhincome <= 74999, "$70,000 to $74,999",
                            ifelse(hhincome <= 79999, "$75,000 to $79,999",
                            ifelse(hhincome <= 84999, "$80,000 to $84,999",
                            ifelse(hhincome <= 89999, "$85,000 to $89,999",
                            ifelse(hhincome <= 94999, "$90,000 to $94,999",
                            ifelse(hhincome <= 99999, "$95,000 to $99,999",
                            ifelse(hhincome <= 124999, "$100,000 to $124,999",
                            ifelse(hhincome <= 149999, "$125,000 to $149,999",
                            ifelse(hhincome <= 174999, "$150,000 to $174,999",
                            ifelse(hhincome <= 199999, "$175,000 to $199,999",
                            ifelse(hhincome <= 249999, "$200,000 to $249,999", "$250,000 and above"))))))))))))))))))))))))

## Here I am only splitting cells by age, but you 
## can use other variables to split by changing
## count(age) to count(age, sex, ....)

# sample code:"
# reduced_data <- 
#   reduced_data %>%
#   count(age) %>%
#   group_by(age) 
# 
# reduced_data <- 
#   reduced_data %>% 
#   filter(age != "less than 1 year old") %>%
#   filter(age != "90 (90+ in 1980 and 1990)")
# 
# reduced_data$age <- as.integer(reduced_data$age)

# Saving the census data as a csv file in my
# working directory
write_csv(reduced_data, "outputs/census_data.csv")



         