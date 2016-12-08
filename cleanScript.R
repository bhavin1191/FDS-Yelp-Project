
setwd("D:/Fall 2016/Data_Science/Project Data Set/yelp_json_csv_converter")
###review data cleaning

###colclasses helps us to read specific columns
largeData <- read.csv("yelp_academic_dataset_review.csv",
header = TRUE,
colClasses = c("character", "character", "NULL","NULL","character","NULL","numeric","Date","NULL","NULL"))

write.csv(x = largeData,file = "reviews_clean1.csv")

###fetching sample data for 14-15
reviews_1316 = largeData[largeData$date >= "2012-09-01", ]
#reviews_1516 = largeData[largeData$date >= "2015-01-01", ]
review_summary <- summary(reviews_1316)

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

business_clean <- read.csv("business.csv")
business_clean = business_clean[,-1]

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

summary(sports_bar_business)

# sports_bar_business = sports_bar_business[-1]

#reading sample review data
filename = "D:/Fall 2016/Data_Science/Project Data Set/clean_data_set/reviews_1415.csv"
reviews_1415 = read.csv(filename)
reviews_1415 = reviews_1415[,-1]

review_bar <- merge(sports_bar_business,reviews_1316, by="business_id")

# write.csv(x = review_bar,file = "review1316_sports_bar.csv")

# sapply(review_bar,class)
review_bar$city = trimws(review_bar$city,which = "both")

review_bar[grep(".*.Las Vegas?",review_bar$city),]$city = "Las Vegas"