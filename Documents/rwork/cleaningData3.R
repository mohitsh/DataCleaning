
set.seed(13435)
x <- data.frame("var1"=sample(1:5),"var2"=sample(6:10), "var3"=sample(11:15))
x$var2[c(1,3)] <- NA

#using which useful while dealing with NA values
x[which(x$var3>11),]
x[which(x$var2>7),]

#sorting
sort(x$var2)

#ordering the dataset
x[order(x$var1),]

#using plyr
library("plyr")
arrange(x, var1)

fileUrl <- "http://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="rest.csv")
restdata <- read.csv("rest.csv")

#making table
table(restdata$zipCode, useNA="ifany")


#making 2D table
table(restdata$councilDistrict, restdata$zipCode)

#checking for missing values
is.na(restdata$councilDistrict) # this is a logical vector
sum(is.na(restdata$councilDistrict)) #sum 
table(is.na(restdata$councilDistrict)) # or make a table

any(is.na(restdata$councilDistrict))
all(is.na(restdata$councilDistrict))

colSums(is.na(restdata))
all(colSums(is.na(restdata))==0)


# finding specific characters in a column
table(restdata$zipCode %in% c("21212"))

table(restdata$zipCode %in% c("21212", "21213"))

# now fetching these specific values
subs1 <- restdata[(restdata$zipCode %in% c("21212")),]
subs2 <- restdata[(restdata$zipCode %in% c("21212", "21213")),]

print(object.size(data), units="Mb")


# cross tabs
data(UCBAdmissions)
df <- as.data.frame(UCBAdmissions)
xt <- xtabs(Freq~Gender+Admit, data=df)

#subsetting the data
restNearMe <- restdata$neighborhood %in% c("Roland Park", "Homeland")
table(restNearMe)

restdata$zipwrong <- ifelse(restdata$zipCode<0, TRUE, FALSE)
table(restdata$zipwrong,restdata$zipCode<0)

restdata$zipgroup <- cut(restdata$zipCode, breaks = quantile(restdata$zipCode))
table(restdata$zipgroup)
table(restdata$zipgroup, restdata$zipCode)

#making factor variable

yesno <- sample(c("yes", "no"),size=10,replace=T)
yesnofc <- factor(yesno, levels=c("yes", "no"))
relevel(yesnofc, ref="yes")

#reshaping data
#melting the dataframe
install.packages("reshape2")
library("reshape2")
data(mtcars)
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id=c("carname","gear","cyl"), measure.vars=c("mpg", "hp"))
head(carMelt)

# recasting the dataset

cyldata <- dcast(carMelt, cyl~variable)

data(InsectSprays)

# for each value of spray this will count sum of all counts
# pretty good ehh!
tapply(InsectSprays$count, InsectSprays$spray, sum)


spIns <- split(InsectSprays$count, InsectSprays$spray)
spIns <- lapply(spIns,sum)
unlist(spIns)

spIns <- sapply(spIns, sum)

library("plyr")
# using ddplys package for the same thing
spIns1 <- ddply(InsectSprays,.(spray),summarize, sum=sum(count))

#showing sum of count for all values of factor 
spraySums <- ddply(InsectSprays,.(spray),summarize, sum=ave(count, FUN=sum))


#dplyr  package use
install.packages("dplyr")
library("dplyr")

# select funtion
chicago <- readRDS("chicago.rds")


# want column names! yeah! you got it.
names(chicago)

# selecting some particular columns
head(select(chicago, city:dptp))


# okay hate those columns exclude them
head(select(chicago, -(city:dptp)))



#filter; subsetting a dataset based on some conditions
chic.f <- filter(chicago, pm25tmean2>30)


# using arrange function
# arranging the chicago dataframe according to the date

chicago <- arrange(chicago, date)
chicago <- arrange(chicago, desc(date))


# renaming the weired names of dataframe here you go !
chicago <- rename(chicago, pm25=pm25tmean2, dewpoint=dptp)


# using mutate
# to transform and create new variables

chicago <- mutate(chicago, pm25detrend=pm25-mean(pm25, na.rm=TRUE))


# splitting dataframe according to some groups

chicago <- mutate(chicago, tempcat=factor(1*(tmpd>80), labels=c("cold", "hot")))

hotcold <- group_by(chicago, tempcat)

summarize(hotcold, pm=mean(pm25, na.rm=TRUE), o3=max(o3tmean2), no2=max(no2tmean2))


#merging datasets

fileUrl1 = "http://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "http://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"


download.file(fileUrl1,destfile="reviews.csv")
download.file(fileUrl2,destfile="solutions.csv")


reviews <- read.csv("reviews.csv")
solutions <- read.csv("solutions.csv")

#merging datasets together 
# in this based on id

mergedata <- merge(reviews, solutions, by.x="solution_id", by.y="id", all=TRUE)












































