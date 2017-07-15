if(!file.exists("data"))
  dir.create("./data")

#############################################################################
#Question 1
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile = "./data/survey.csv",method="curl")
list.files("./data")

dt <- read.table("./data/survey.csv",sep=",",header = TRUE)
valAbove_10L <- dt[dt$VAL >= 1000000,]
nrow(valAbove_10L)
###########################################################################
#Question 3
library(xlsx)
fileUrl1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl1,destfile = "./data/gas.xlsx",method="curl")
list.files("./data")

rowIdex = 18:23
colIndex = 7:15
dat <- read.xlsx("./data/gas.xlsx",header=TRUE,sheetIndex = 1,rowIndex = rowIdex,colIndex = colIndex)
sum(dat$Zip*dat$Ext,na.rm=T)
##################################################################
#Question 4
library(XML)
fileUrl2 <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl2,destfile = "./data/restaurants.xml",method="curl")

doc <- xmlTreeParse(fileUrl2,useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
temp <- xpathSApply(rootNode,"//zipcode",xmlValue)
sum(temp == 21231)
################################################################################
#Question 5
DT <- fread("./data/survey.csv")
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(rowMeans(DT)[DT$SEX==1]) + system.time(rowMeans(DT)[DT$SEX==2])
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15))+system.time(mean(DT[DT$SEX==2,]$pwgtp15))
