library(httr)
require(httpuv)
#oauth_endpoints("github")
#myapp <- oauth_app("Coursera",key="262f62f0c548ac2be1ac",secret="11155a2d3c6612d62e15c6807e6b05186c3dd036")

#github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)


#gtoken <- config(token = github_token)
#req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
#stop_for_status(req)
#content(req)*/

#Question 1
library(jsonlite)
jsondata<-fromJSON("https://api.github.com/users/jtleek/repos")
jsondata$created_at[jsondata$name=="datasharing"]
#Answer - 2013-11-07T13:25:07Z
################################################################
#Question 2
if(!file.exists("data"))
  dir.create("./data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl,destfile = "./data/americanSurvey.csv",method="curl")
list.files("./data")

acs <- read.table("./data/americanSurvey.csv",sep=",",header = TRUE)
#Answer - sqldf("select pwgtp1 from acs where AGEP < 50")
#############################################################################
#Question 3 - Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)
#Answer - sqldf("select distinct AGEP from acs")

##################################################################
#Question4
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
html<- readLines(con)
close(con)
c(nchar(html[10]), nchar(html[20]), nchar(html[30]), nchar(html[100]))
#[1] 45 31  7 25

##################################################################
#Question 5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
lines <- readLines(url, n = 10)

widths <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)
colNames <- c("sep", "b", "sep", "d", "sep", "f", 
              "sep", "h", "sep", "j", "sep", "l", "sep", 
              "n", "sep", "p", "sep", "r")
d <- read.fwf(url, w, header = FALSE, skip=4,col.names = colNames)

d <- d[, grep("^[^sep]", names(d))]
sum(d[, 4])
#Answer  32426.7

