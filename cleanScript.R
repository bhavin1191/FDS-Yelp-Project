
setwd("<filepath>")
###review data cleaning

###colclasses helps us to read specific columns
largeData <- read.csv("yelp_academic_dataset_review.csv",
header = TRUE,
colClasses = c("character", "character", "NULL","NULL","character","NULL","numeric","Date","NULL","NULL"))

write.csv(x = largeData,file = "reviews_clean1.csv")

###fetching sample data for 14-15
reviews_1415 = largeData[largeData$date >= "2014-01-01", ]
#reviews_1516 = largeData[largeData$date >= "2015-01-01", ]

write.csv(x = reviews_1415,file = "reviews_1415.csv")

### Business Data Set Cleaninig
library(rjson)
filename = "yelp_academic_dataset_business.json"
con = file(filename, "r")
input <- readLines(con, -1L)
test <- lapply(input, fromJSON)
test <- lapply(test, cbind)
test <- as.data.frame(test)
test <- as.data.frame(t(test))
row.names(test) <- seq(1, nrow(test))
business_clean <- test[c(1,5,6,7,8,11,12)]

business_clean$categories <- as.character(business_clean$categories)
business_clean$review_count <- as.numeric(business_clean$review_count)
business_clean$business_id <- as.character(business_clean$business_id)
business_clean$stars <- as.numeric(business_clean$stars)
business_clean$city = as.character(business_clean$city)
business_clean$state = as.character(business_clean$state)

business_clean$name = as.character(business_clean$name)
write.csv(x = business_clean,file = "business.csv")

#filtering business records for sports bars
library(dplyr)
bar_business <- filter(business_clean,grepl("Bars",x = categories))
sports_bar_business <- filter(bar_business,grepl("Sports Bars",x = categories))

#reading sample review data
filename = "D:/Fall 2016/Data_Science/Project Data Set/clean_data_set/reviews_1415.csv"
reviews_1415 = read.csv(filename)
reviews_1415 = reviews_1415[,-1]

review_bar <- merge(sports_bar_business,reviews_1415, by="business_id")
write.csv(x = largeData,file = "review1415_bar.csv")

filename = "D:/Fall 2016/Data_Science/Project Data Set/clean_data_set/reviews_clean.csv"
reviews_clean = read.csv(filename)
reviews_clean = reviews_clean[,-1]

review_bar <- merge(sports_bar_business,reviews_clean, by="business_id")
write.csv(x = review_bar,file = "review_bar.csv")
