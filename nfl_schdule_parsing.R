setwd("D:/Fall 2016/Data_Science/Project Data Set/NFL Calendar")

raw_schedule <- read.csv("NFLSchedule_1316.csv")
raw_schedule = raw_schedule[-1]
raw_schedule$Week = as.character(raw_schedule$Week)

raw_schedule$Week = ifelse(raw_schedule$Week == "WildCard",18,raw_schedule$Week)
raw_schedule$Week = ifelse(raw_schedule$Week == "Division",19,raw_schedule$Week)
raw_schedule$Week = ifelse(raw_schedule$Week == "ConfChamp",20,raw_schedule$Week)
raw_schedule$Week = ifelse(raw_schedule$Week == "SuperBowl",21,raw_schedule$Week)

raw_schedule$Week = as.numeric(raw_schedule$Week)
raw_schedule$Date = as.Date(raw_schedule$Date)

measure_week = data.frame(raw_schedule$Week,raw_schedule$Date)
colnames(measure_week) = c("Week","Date")

#find unique values
unq_measure_week = unique(measure_week)

nextdates = data.frame(unq_measure_week$Week,unq_measure_week$Date + 1)
colnames(nextdates) = c("Week","Date")

scheduled_dates_for_review <- rbind(unq_measure_week,nextdates)

scheduled_dates_for_review$Day <- weekdays(as.Date(scheduled_dates_for_review$Date))

write.csv(x = scheduled_dates_for_review,file = "nfl_scheduled_dates_for_review.csv")
