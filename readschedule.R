#Script to get the NFL schedule
#date,team,city,final/quarterfinal
#http://www.fftoday.com/nfl/schedule.php
#http://static.pfref.com/years/2015/games.htm#games::none

#2016 schedule

install.packages('XML')
library(XML)
library(htmltools)
library(ggplot2)
setwd('D:/Fall 2016/Data_Science/Project Data Set/raw_data')

#2013 Schedule
htmldoc <- htmlParse("http://static.pfref.com/years/2012/games.htm#games::none",isURL = TRUE,isHTML = TRUE)
#htmldoc
#reading the table contents from the html document using the readHTMLTable
NFLSchedule2012 <- readHTMLTable(htmldoc,as.data.frame = TRUE,which = 1)
NFLSchedule2012 <- NFLSchedule2013[-c(17,34,51,67,82,98,114,128,142,157,173,188,205,222,239,256,273),]

NFLSchedule2012_clean <- NFLSchedule2013[,c(1,2,3,4,5,7)]
NFLSchedule2012_clean['Year'] = 2012
write.csv(x = NFLSchedule2012_clean,file = "NFLSchedule2012_clean.csv")

#2013
htmldoc <- htmlParse("http://static.pfref.com/years/2013/games.htm#games::none",isURL = TRUE,isHTML = TRUE)
#htmldoc
#reading the table contents from the html document using the readHTMLTable
NFLSchedule2013 <- readHTMLTable(htmldoc,as.data.frame = TRUE,which = 1)
NFLSchedule2013 <- NFLSchedule2013[-c(17,34,51,67,82,98,114,128,142,157,173,188,205,222,239,256,273),]

NFLSchedule2013_clean <- NFLSchedule2013[,c(1,2,3,4,5,7)]
NFLSchedule2013_clean['Year'] = 2013
write.csv(x = NFLSchedule2013_clean,file = "NFLSchedule2013_clean.csv")

#2014 Schedule
htmldoc <- htmlParse("http://static.pfref.com/years/2014/games.htm#games::none",isURL = TRUE,isHTML = TRUE)
#htmldoc
#reading the table contents from the html document using the readHTMLTable
NFLSchedule2014 <- readHTMLTable(htmldoc,as.data.frame = TRUE,which = 1)
NFLSchedule2014 <- NFLSchedule2014[-c(17,34,51,65,81,97,113,129,143,157,172,188,205,222,239,256,273),]

NFLSchedule2014_clean <- NFLSchedule2014[,c(1,2,3,4,5,7)]
NFLSchedule2014_clean['Year'] = 2014
write.csv(x = NFLSchedule2014_clean,file = "NFLSchedule2014_clean.csv")

#2015 Schedule
htmldoc <- htmlParse("http://static.pfref.com/years/2015/games.htm#games::none",isURL = TRUE,isHTML = TRUE)
#htmldoc
#reading the table contents from the html document using the readHTMLTable
NFLSchedule2015 <- readHTMLTable(htmldoc,as.data.frame = TRUE,which = 1)
NFLSchedule2015 <- NFLSchedule2015[-c(17,34,51,67,82,97,112,127,141,156,171,188,205,222,239,256,273),]

NFLSchedule2015_clean <- NFLSchedule2015[,c(1,2,3,4,5,7)]
NFLSchedule2015_clean['Year'] = 2015
write.csv(x = NFLSchedule2015_clean,file = "NFLSchedule2015_clean.csv")


#2016 schedule
htmldoc <- htmlParse("http://static.pfref.com/years/2016/games.htm#games::none",isURL = TRUE,isHTML = TRUE)
#htmldoc
#reading the table contents from the html document using the readHTMLTable
NFLSchedule2016 <- readHTMLTable(htmldoc,as.data.frame = TRUE,which = 1)
NFLSchedule2016 <- NFLSchedule2016[-c(17,34,51,67,82,98,114,128,142,157,172,189,205,222,239,256),]

NFLSchedule2016_clean <- NFLSchedule2016[,c(1,2,3,4,5,7)]
NFLSchedule2016_clean['Year'] = 2016
write.csv(x = NFLSchedule2016_clean,file = "NFLSchedule2016_clean.csv")

#combine dataframe into single dataframe
NFLSchedule_1216 <- rbind(NFLSchedule2012_clean,NFLSchedule2013_clean, NFLSchedule2014_clean, NFLSchedule2015_clean, NFLSchedule2016_clean)

#convert to date format yyyy-mm-dd
NFLSchedule_1216$Date1 <- do.call(paste, c(NFLSchedule_1216[c("Date", "Year")], sep = " ")) 

NFLSchedule_1216$Date1  <- as.Date(NFLSchedule_1216$Date1, "%B%d%Y")
NFLSchedule_1216 <- NFLSchedule_1216[-3]
names(NFLSchedule_1216)[names(NFLSchedule_1216)=="Date1"] <- "Date"
NFLSchedule_1216 <- NFLSchedule_1216[-6]


#NFLSchedule_1316$Week = as.numeric(NFLSchedule_1316$Week)
#NFLSchedule_1316$Day = as.character(NFLSchedule_1316$Day)
#NFLSchedule_1316$Time = as.character(NFLSchedule_1316$Time)
#NFLSchedule_1316$`Winner/tie` = as.character(NFLSchedule_1316$`Winner/tie`)
#NFLSchedule_1316$`Loser/tie` = as.character(NFLSchedule_1316$`Loser/tie`)

match(x = "Day",table = NFLSchedule_1216$Day)

NFLSchedule_1216 = NFLSchedule_1216[!NFLSchedule_1216$Day == "Day",]
sapply(NFLSchedule_1216,class)
NFLSchedule_1216$Day = as.character(NFLSchedule_1216$Day)
NFLSchedule_1216$Day = as.factor(NFLSchedule_1216$Day)
write.csv(x = NFLSchedule_1216,file = "NFLSchedule_1216.csv")
NFLSchedule_1216 = NFLSchedule_1216[NFLSchedule_1216$Date >= "2012-09-01",]

barplot(summary(NFLSchedule_1216$Day),col = c("red","blue","green","yellow","grey"))
axis(2,)
barplot(summary(NFLSchedule_1216$Time))
sort(summary(NFLSchedule_1216$Time))
