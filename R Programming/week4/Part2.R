
###########################################################################################
#2. Finding the best hospital in the state

best<-function(state,outcome){
  outcome_data <- read.csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses="character")
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
  
  resultdf <- outcome_data[outcome_data[,7]==state,]
  min <- min(resultdf[,index],na.rm=TRUE)
  min_index <- which(resultdf[,index]==min)
  
  #resultdf <- resultdf[order(resultdf[,index]),]
  # resultdf[1,2]
  #resultdf[0,2]
  answer <- resultdf[min_index,2]
  answer
}
best("TX","heart attack")
best("MD", "pneumonia")
