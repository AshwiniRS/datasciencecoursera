#1. Plot the 30 day mortality rates for heart attack

outcome <- read.csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses="character")
#head(outcome)

#make the 11th column numeric type 
outcome[,11] <- as.numeric(outcome[,11])
hist(outcome[,11])
