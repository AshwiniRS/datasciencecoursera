#Question 1
if(!file.exists("data"))
  dir.create("./data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile = "./data/americanSurvey.csv",method="curl")
list.files("./data")

survey <- read.table("./data/americanSurvey.csv",sep=",",header = TRUE)
agricultureLogical <- survey$ACR == 3 & survey$AGS == 6
which(agricultureLogical)[1:3]
#Answer - [1] 125 238 262

#############################################################################
#Question 2
library("jpeg")
if(!file.exists("data"))
  dir.create("./data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl,destfile = "./data/jeff.jpg",method="curl")
list.files("./data")
img <- readJPEG("./data/jeff.jpg", native=TRUE)
quantile(img, probs=c(0.3, 0.8))

#Answer -   30%       80% 
#         -15259150 -10575416 
#############################################################################
#Question 3

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl,destfile = "./data/GDP.csv",method="curl")
#list.files("./data")

fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl1,destfile = "./data/country.csv",method="curl")
list.files("./data")

library(data.table)
gdp <- data.table(read.csv("./data/GDP.csv",skip=4,nrows=215))
country <- data.table(read.csv("./data/country.csv"))

gdp <- gdp[X != ""]
gdp <- gdp[, list(X, X.1, X.3, X.4)]
setnames(gdp, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rank_GDP", "Long.Name", "gdp"))
dt <- merge(gdp, country, all=TRUE, by=c("CountryCode"))
sum(!is.na(unique(dt$rank_GDP)))
dt[order(rank_GDP, decreasing=TRUE), list(CountryCode, Long.Name.x, Long.Name.y, rank_GDP, gdp)][13]

#Answer [1] 189
#  CountryCode         Long.Name.x         Long.Name.y rank_GDP   gdp
#1:         KNA St. Kitts and Nevis St. Kitts and Nevis      178  767

#############################################################################
#Question 4
dt[, mean(rank_GDP, na.rm=TRUE), by=Income.Group]
#Answer  -1: High income: nonOECD  91.91304
#         5:    High income: OECD  32.96667

############################################################################
#Question 5
breaks <- quantile(dt$rank_GDP, probs=seq(0, 1, 0.2), na.rm=TRUE)
dt$quantGDP <- cut(dt$rank_GDP, breaks=breaks)
dt[Income.Group == "Lower middle income", .N, by=c("Income.Group", "quantGDP")]