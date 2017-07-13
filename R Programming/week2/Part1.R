

pollutantmean <- function(directory, pollutant, id=1:332){
  directoy <- "./specdata"
  file.names <- as.character(list.files("./specdata/"))
  file.paths <- paste(directory,file.names,sep="/")
  all_mean <- c()
  for(i in id){
    current.file <- read.table(file.paths[i],header=TRUE,sep=",",row.names=NULL)
    #remove na
    current.file <- current.file[!is.na(current.file[,pollutant]),pollutant]
    all_mean <- c(all_mean,current.file)
  }
  mean_result <- mean(all_mean)
  mean_result
}

pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "nitrate", 23)