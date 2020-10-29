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


#### Workspace setup ###
library(haven)
library(tidyverse)
library(plyr)

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
race_mapping <- c("White" = "white", "Black, or African American" = "black/african american/negro", 
                  "American Indian or Alaska Native" = "american indian or alaska native", 
                  "Asian (Japanese)" = "japanese", "Asian (Chinese)" = "chinese", 
                  "Asian (Other)" = "other asian or pacific islander", "Asian (Vietnamese)" = "other asian or pacific islander",
                  "Asian (Asian Indian)" = "other asian or pacific islander", "Asian (Korean)" = "other asian or pacific islander", 
                  "Asian (Filipino)" = "other asian or pacific islander",
                  "Pacific Islander (Native Hawaiian)" = "other asian or pacific islander", "Pacific Islander (Other)" = "other asian or pacific islander", 
                  "Pacific Islander (Samoan)" = "other asian or pacific islander", "Pacific Islander (Guamanian)" = "other asian or pacific islander", 
                  "Some other race" = "other race, nec")

reduced_data<-
  reduced_data %>%
  mutate(vote_trump =
           ifelse(vote_2020=="Donald Trump", 1, ifelse(vote_2020=="Joe Biden",0,-1))) %>%
  mutate(race=revalue(race_ethnicity, race_mapping)) %>% 
  filter(vote_trump != -1)


# Saving the survey/sample data as a csv file in my
# working directory
write_csv(reduced_data, "outputs/survey_data.csv")

