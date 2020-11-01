#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from https://www.voterstudygroup.org/downloads?key=dd05a560-c382-42f1-a3e4-7e5318f9781a
# (UCLA + Democracy Fund)
# Author: Lisa Oh, Saksham Ahluwalia, Labib Chowdhury, Eric Yuan
# Data: 2 November 2020
# Contact: ishmamlabib.chowdhury@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data from Democracy Fund and save the folder that you're 
# interested in to inputs/data 
# - Don't forget to gitignore it!


#### Workspace setup ###
library(haven)
library(plyr)
library(tidyverse)

#LABIBS WD

#WD = "/Users/labibchowdhury/coursework/STA304/ps3/US-Presidential-Election-2020-Popular-Vote-Prediction"

#ERICS WD
WD = "~/Desktop"


#LISAS WD
#WD = "/Users/Lisa/Desktop/PS3"

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

state_mapping <-  c("AK" = "alaska",
                    "AL" = "alabama",
                    "AR" = "arkansas",
                    "AZ" = "arizona",
                    "CA" = "california",
                    "CO" = "colorado",
                    "CT" = "connecticut",
                    "DC" = "district of columbia",
                    "DE" = "delaware",
                    "FL" = "florida",
                    "GA" = "georgia",
                    "HI" = "hawaii",
                    "IA" = "iowa",
                    "ID" = "idaho",
                    "IL" = "illinois",
                    "IN" = "indiana",
                    "KS" = "kansas",
                    "KY" = "kentucky",
                    "LA" = "louisiana",
                    "MA" = "massachusetts",
                    "MD" = "maryland",
                    "ME" = "maine",
                    "MI" = "michigan",
                    "MN" = "minnesota",
                    "MO" = "missouri",
                    "MS" = "mississippi",
                    "MT" = "montana",
                    "NC" = "north carolina",
                    "ND" = "north dakota", 
                    "NE" = "nebraska",
                    "NH" = "new hampshire",
                    "NJ" = "new jersey",
                    "NM" = "new mexico",
                    "NV" = "nevada", 
                    "NY" = "new york",
                    "OH" = "ohio",
                    "OK" = "oklahoma", 
                    "OR" = "oregon",
                    "PA" = "pennsylvania",
                    "RI" = "rhode island",
                    "SC" = "south carolina",
                    "SD" = "south dakota",
                    "TN" = "tennessee",
                    "TX" = "texas",
                    "UT" = "utah", 
                    "VA" = "virginia",
                    "VT" = "vermont",
                    "WA" = "washington",
                    "WI" = "wisconsin", 
                    "WV" = "west virginia",
                    "WY" = "wyoming")

reduced_data<-
  reduced_data %>%
  mutate(vote_trump =
           ifelse(vote_2020=="Donald Trump", 1, ifelse(vote_2020=="Joe Biden", 0, -1))) %>%
  mutate(race=revalue(race_ethnicity, race_mapping)) %>%
  mutate(statefip=revalue(state, state_mapping)) %>%
  filter(vote_trump != -1)

reduced_data <- reduced_data %>% 
  filter(as.numeric(age) >= 18) %>% 
  mutate(age_cat = ifelse(as.numeric(age) <= 25, "18-25",
                   ifelse(as.numeric(age) <= 35, "26-35",
                   ifelse(as.numeric(age) <= 45, "36-45",
                   ifelse(as.numeric(age) <= 55, "46-55",
                   ifelse(as.numeric(age) <= 65, "56-65",
                   ifelse(as.numeric(age) <= 75, "66-75",
                   ifelse(as.numeric(age) <= 85, "76-85", "85 and over"))))))))


# Saving the survey/sample data as a csv file in my
# working directory
write_csv(reduced_data, "outputs/survey_data.csv")

