#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Rohan Alexander and Sam Caetano [CHANGE THIS TO YOUR NAME!!!!]
# Data: 22 October 2020
# Contact: rohan.alexander@utoronto.ca [PROBABLY CHANGE THIS ALSO!!!!]
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data from X and save the folder that you're 
# interested in to inputs/data 
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)


#LABIBS WD

WD = "/Users/labibchowdhury/coursework/STA304/ps3/US-Presidential-Election-2020-Popular-Vote-Prediction"

#ERICS WD
# WD = 

#LISAS WD
#WD =

#SAKSHAMS WD
#WD = "C:/Users/saksh/Desktop/STA304/Pset3"

setwd(WD)
# Read in the raw data (You might need to change this if you use a different dataset)
raw_data <- read_dta("inputs/ns20200625/ns20200625.dta")
# Add the labels
raw_data <- labelled::to_factor(raw_data)
# Just keep some variables
reduced_data <- 
  raw_data %>% 
  select(vote_2020,
         race_ethnicity,
         household_income,
         state,
         age)


#### What else???? ####
# Maybe make some age-groups?
# Maybe check the values?
# Is vote a binary? If not, what are you going to do?

#Mapping according to IPUMS
race_mapping <- c("White" = 1, "Black, or African American" = 2, "American Indian or Alaska Native" = 3, 
                  "Asian (Chinese)" = 4, "Asian (Japanese)" = 5, "Asian (Other)" = 6, "Asian (Vietnamese)" = 6,
                  "Asian (Asian Indian)" = 6, "Asian (Korean)" = 6, "Asian (Filipino)" = 6,
                  "Pacific Islander (Native Hawaiian)" = 6, "Pacific Islander (Other)" = 6, 
                  "Pacific Islander (Samoan)" = 6, "Pacific Islander (Guamanian)" = 6, "Some other race" = 7)

reduced_data<-
  reduced_data %>%
  mutate(vote_trump =
           ifelse(vote_2020=="Donald Trump", 1, ifelse(vote_2020=="Joe Biden",0,-1))) %>%
  mutate(race=race_mapping[race_ethnicity]) %>% 
  filter(vote_trump != -1)


# Saving the survey/sample data as a csv file in my
# working directory
write_csv(reduced_data, "outputs/survey_data.csv")

