corr <- function(directory, threshold=0){
  directory <- './specdata/'
 
  file.names <- as.character(list.files("./specdata/"))
  file.paths <- paste(directory,file.names,sep="/")
  comp_df <- complete("specdata",1:332)
  comp_df_nobs <- comp_df$nobs
  comp_df_ids <- comp_df$id[comp_df_nobs>threshold]
  corr_vec <- c()
  
  for(i in comp_df_ids){
    current.file <- read.table(file.paths[i],header=TRUE, sep=",")
    temp <- cor(current.file$sulfate,current.file$nitrate,use="complete.obs")
    corr_vec <- c(corr_vec,temp)
  }
  corr_vec
}

cr <- corr("specdata", 400)
head(cr)
cr <- corr("specdata", 5000)
summary(cr)
cr <- corr("specdata")
summary(cr)
