


####################################################################################
#3. Ranking hospitals by outcome in a state

rankhospital <- function(state,outcome,num){
  outcome_data <- read.csv("week4/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses="character")
 
  outcome_data[,11] <- as.numeric(outcome_data[,11])
  outcome_data[,17] <- as.numeric(outcome_data[,17])
  outcome_data[,23] <- as.numeric(outcome_data[,23])
  
  if(!state %in% outcome_data$State)
    stop("invalid state")
  
  if(outcome == "heart attack")
    index = 11
  else if(outcome == "heart failure")
    index = 17
  else if(outcome == "pneumonia")
    index = 23
  else
    stop("invalid outcome")
  outcome_data <- outcome_data[complete.cases(outcome_data[c(index)]),]
  
  resultdf <- outcome_data[outcome_data[,7]==state,]
  sorted_df <- resultdf[order(resultdf[,index],resultdf[,2]),]
  if(num == "best")
    answer <- sorted_df[1,2]
  else if(num == "worst")
    answer <- sorted_df[nrow(sorted_df),2]
  else if(num > nrow(sorted_df))
    answer <- NA
  else
    answer <- sorted_df[num,2]
  answer
}
rankhospital("TX", "heart failure", 4)