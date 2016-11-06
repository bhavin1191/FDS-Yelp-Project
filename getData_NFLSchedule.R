#Script to get the NFL schedule
#date,team,city,final/quarterfinal
#http://www.fftoday.com/nfl/schedule.php
#http://static.pfref.com/years/2015/games.htm#games::none

#2016 schedule

install.packages('XML')
library(XML)
setwd('C:/Users/OM NAMAH SHIVAY/Desktop/Study/Foundation of Data Science/Project/data')


#2013 Schedule
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
NFLSchedule_1316 <- rbind(NFLSchedule2013_clean, NFLSchedule2014_clean, NFLSchedule2015_clean, NFLSchedule2016_clean)

#convert to date format yyy-mm-dd
NFLSchedule_1316$Date1 <- do.call(paste, c(NFLSchedule_1316[c("Date", "Year")], sep = " ")) 

NFLSchedule_1316$Date1  <- as.Date(NFLSchedule_1316$Date1, "%B%d%Y")
NFLSchedule_1316 <- NFLSchedule_1316[-3]
names(NFLSchedule_1316)[names(NFLSchedule_1316)=="Date1"] <- "Date"
NFLSchedule_1316 <- NFLSchedule_1316[-6]
NFLSchedule_1316$Week = as.numeric(NFLSchedule_1316$Week)
NFLSchedule_1316$Day = as.character(NFLSchedule_1316$Day)
NFLSchedule_1316$Time = as.character(NFLSchedule_1316$Time)
NFLSchedule_1316$`Winner/tie` = as.character(NFLSchedule_1316$`Winner/tie`)
NFLSchedule_1316$`Loser/tie` = as.character(NFLSchedule_1316$`Loser/tie`)

write.csv(x = NFLSchedule_1316,file = "NFLSchedule_1316.csv")
