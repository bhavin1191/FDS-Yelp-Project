setwd('C:/Users/OM NAMAH SHIVAY/Desktop/Study/Foundation of Data Science/Project')

largeData <- read.csv("C:/Users/OM NAMAH SHIVAY/Desktop/Study/Foundation of Data Science/Project/data/yelp_academic_dataset_review.csv",
header = TRUE,
colClasses = c("character", "character", "NULL","NULL","character","NULL","numeric","Date","NULL","NULL"))

write.csv(x = largeData,file = "reviews_clean1.csv")


reviews_1415 = largeData[largeData$date >= "2014-01-01", ]
reviews_1516 = largeData[largeData$date >= "2015-01-01", ]
write.csv(x = reviews_1415,file = "reviews_1415.csv")

## Business Data

#BusinessData <- read.csv("C:/Users/OM NAMAH SHIVAY/Desktop/Study/Foundation of Data Science/Project/data/yelp_academic_dataset_business.csv",
#header = TRUE,
#colClasses = c("NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL"
#               ,"character","NULL","NULL","NULL","NULL","character","NULL","NULL","character","NULL","NULL","NULL","NULL","NULL"
#               ,"NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","numeric","NULL","character"
#               ,"NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL"
#               ,"character")
#)

## *()()()()

library(rjson)

filename = "C:/Users/OM NAMAH SHIVAY/Desktop/Study/Foundation of Data Science/Project/data/yelp_academic_dataset_business.json"
con = file(filename, "r")
input <- readLines(con, -1L)
#business.training <- lapply(X=input,fromJSON)
test <- lapply(input, fromJSON)
test <- lapply(test, cbind)
test <- as.data.frame(test)
test <- as.data.frame(t(test))
row.names(test) <- seq(1, nrow(test))
check <- test[c(1,5,6,7,8,11,12)]

check$categories <- as.character(check$categories)
check$review_count <- as.numeric(check$review_count)
check$business_id <- as.character(check$business_id)
check$stars <- as.numeric(check$stars)
check$city = as.character(check$city)
check$state = as.character(check$state)

check$name = as.character(check$name)
write.csv(x = check,file = "business.csv")
