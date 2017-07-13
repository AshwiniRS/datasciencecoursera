
complete <- function(directory,id=1:332){
  directoy <- "./specdata"
  file.names <- as.character(list.files("./specdata/"))
  file.paths <- paste(directory,file.names,sep="/")
  
  complete.entries <- c()
  for(i in id){
    current.file <- read.table(file.paths[i],header=TRUE, sep=",")
    complete.entries <- c(complete.entries,sum(complete.cases(current.file)))
  }
  result <- data.frame(id = id, nobs = complete.entries)
  result
}

complete("specdata", 1)

complete("specdata", c(2, 4, 8, 10, 12))

complete("specdata", 30:25)

complete("specdata", 3)

