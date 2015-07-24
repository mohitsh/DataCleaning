

data <- read.csv("comm.csv")

data1 <- subset(data, ACR==3 & AGS==6)

which(data1)


pic <- readJPEG("getdata-jeff.jpg", native=TRUE)
quantile(pic, probs=c(.3,.8))

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
              destfile="gdp.csv")
gdp <- read.csv("gdp.csv")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
              destfile="edu.csv")
edu <- read.csv("edu.csv")

library(dplyr)
dataM <- merge(gdp,edu, by=c("CountryCode"), all=TRUE)