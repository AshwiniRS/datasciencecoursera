rankall <- function(outcome,num="best"){
  outcome_data <- read.csv("week4/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses="character")
  
  
  outcome_data[,11] <- as.numeric(outcome_data[,11])
  outcome_data[,17] <- as.numeric(outcome_data[,17])
  outcome_data[,23] <- as.numeric(outcome_data[,23])
  
  all_States <- sort(unique(outcome_data$State))
  state_len <- length(all_States)
  
  hospitalVector <- rep("",state_len)
  
  for(i in 1:state_len){
    
    state = all_States[i];
    hospitalVector[i] <- rankhospital(state,outcome,num)
    
  }
  
  result_df <- data.frame(hospital=hospitalVector,state=all_States)
  result_df
}
head(rankall("heart attack", 20), 10)
head(rankall("heart attack", 20), 10)
tail(rankall("heart failure"), 10)
