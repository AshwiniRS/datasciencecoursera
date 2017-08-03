#Question 1
if(!file.exists("data"))
  dir.create("./data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile = "./data/americanSurvey.csv",method="curl")
list.files("./data")
acs <- read.table("./data/americanSurvey.csv",sep=",",header = TRUE)

colNamesSplit <- strsplit(names(acs), "wgtp")
colNamesSplit[[123]]

#Answer
#[1] ""   "15"
###################################################################################
#Question 2

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl,destfile = "./data/GDP.csv",method="curl")
list.files("./data")
gdp <- data.table(read.csv("./data/GDP.csv",skip=4,nrows=215))

gdp <- gdp[X != ""]
gdp <- gdp[, list(X, X.1, X.3, X.4)]
setnames(gdp, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rank_GDP", "Long.Name", "gdp"))
gdp1 <- as.numeric(gsub(",", "", gdp$gdp))
mean(gdp1, na.rm=TRUE)
#Answer -  [1] 377652.4
#####################################################################################

#Question 3
grep("^United",gdp$Long.Name,value=TRUE)
#Answer -- [1] "United States"        "United Kingdom"       "United Arab Emirates"

#####################################################################################3

#Question 4
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
isFiscalYearEnd <- grepl("fiscal year end", tolower(dt$Special.Notes))
isJune <- grepl("june", tolower(dt$Special.Notes))
table(isFiscalYearEnd, isJune)
#Answer -                isJune
#isFiscalYearEnd FALSE TRUE
#FALSE   203    3
#TRUE     19   13
#########################################################################################

#Question 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
addmargins(table(year(sampleTimes), weekdays(sampleTimes)))
#Friday Monday Thursday Tuesday Wednesday  Sum
#2007     51     48       51      50        51  251
#2008     50     48       50      52        53  253
#2009     49     48       51      52        52  252
#2010     50     47       51      52        52  252
#2011     51     46       51      52        52  252
#2012     51     47       51      50        51  250
#2013     51     48       50      52        51  252
#2014     50     48       50      52        52  252
#2015     49     48       51      52        52  252
#2016     51     46       51      52        52  252
#2017     29     27       30      30        30  146
#Sum     532    501      537     546       548 2664
