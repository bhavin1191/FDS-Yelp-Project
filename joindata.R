install.packages('XML')
library(XML)

install.packages('sqldf')
library(sqldf)

setwd('D:/Fall 2016/Data_Science/Project Data Set/processed_data')

nfl_scheduled_dates_for_review <- read.csv("nfl_scheduled_dates_for_review.csv",
                                  header = TRUE)
nfl_scheduled_dates_for_review = nfl_scheduled_dates_for_review[-1]
nfl_scheduled_dates_for_review$Week = as.numeric(nfl_scheduled_dates_for_review$Week)
nfl_scheduled_dates_for_review$Date = as.Date(nfl_scheduled_dates_for_review$Date)
nfl_scheduled_dates_for_review$Day = as.character(nfl_scheduled_dates_for_review$Day)
nfl_scheduled_dates_for_review = nfl_scheduled_dates_for_review[order(nfl_scheduled_dates_for_review$Date),]



review_onlybar <- read.csv("review_bar.csv",header = TRUE)
review_onlybar = review_bar
#colClasses = c("numeric", "character", "character","character","numeric","character","character","numeric","character","character","numeric","Date"))
review_bar = review_bar[-1]
review_bar$business_id = as.character(review_bar$business_id)
review_bar$categories = as.character(review_bar$categories)
review_bar$city = as.character(review_bar$city)
review_bar$review_count = as.numeric(review_bar$review_count)
review_bar$name = as.character(review_bar$name)
review_bar$state = as.character(review_bar$state)
review_bar$stars.x = as.numeric(review_bar$stars.x)
review_bar$user_id = as.character(review_bar$user_id)
review_bar$review_id = as.character(review_bar$review_id)
review_bar$stars.y = as.numeric(review_bar$stars.y)
review_bar$date = as.Date(review_bar$date)
names(review_bar)[names(review_bar)=="date"] <- "Date"

review_bar_NFL_join = merge(x = review_bar, y = nfl_scheduled_dates_for_review, by = "Date")
review_bar_NFL_join = review_bar_NFL_join[-3]
write.csv(x = review_bar_NFL_join,file = "review_bar_NFL_join.csv")

# review_onlybar <- read.csv("review_bar.csv",header = TRUE)
# review_onlybar = review_bar
# #colClasses = c("numeric", "character", "character","character","numeric","character","character","numeric","character","character","numeric","Date"))
# review_onlybar = review_onlybar[-1]
# review_onlybar$business_id = as.character(review_onlybar$business_id)
# review_onlybar$categories = as.character(review_onlybar$categories)
# review_onlybar$city = as.character(review_onlybar$city)
# review_onlybar$review_count = as.numeric(review_onlybar$review_count)
# review_onlybar$name = as.character(review_onlybar$name)
# review_onlybar$state = as.character(review_onlybar$state)
# review_onlybar$stars.x = as.numeric(review_onlybar$stars.x)
# review_onlybar$user_id = as.character(review_onlybar$user_id)
# review_onlybar$review_id = as.character(review_onlybar$review_id)
# review_onlybar$stars.y = as.numeric(review_onlybar$stars.y)
# review_onlybar$date = as.Date(review_onlybar$date)
# names(review_onlybar)[names(review_onlybar)=="date"] <- "Date"
# 
# review_onlybar_NFL_join = merge(x = review_onlybar, y = nfl_scheduled_dates_for_review, by = "Date")
# write.csv(x = review_onlybar_NFL_join,file = "review_onlybar_NFL_join.csv")

