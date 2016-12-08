install.packages("DataCombine")
library(DataCombine)
library(caret)
library(data.table)
library(RTextTools)
library(e1071)
library(sqldf)

setwd("D:/Fall 2016/Data_Science/Project Data Set/processed_data")
sports_analysis_data <- read.csv("review_bar_NFL_join.csv")
sports_analysis_data <- review_bar_NFL_join
sapply(sports_analysis_data,class)
sports_analysis_data$Date = as.Date(x = sports_analysis_data$Date)
sports_analysis_data$Date = format(sports_analysis_data$Date, "%Y")

#select subset data to fill in the missing data
subset_ref_fill_in = sqldf("select Date,City,State, Week,count(review_id) from sports_analysis_data group by State,city,Date,week order by State,city,Date,Week")
colnames(subset_ref_fill_in)=c("Date","city","state","Week","count")
sapply(subset_ref_fill_in,class)

subset_ref_fill_in$count = as.numeric(subset_ref_fill_in$count)
subset_ref_fill_in$Date = as.numeric(subset_ref_fill_in$Date)
subset_ref_fill_in$Week = as.numeric(subset_ref_fill_in$Week)

see_unique = unique(subset_ref_fill_in[c(1,2,3)])
sapply(see_unique,class)
see_unique$city = as.character(see_unique$city)
see_unique$state = as.character(see_unique$state)

city_state = unique(see_unique[c(2,3)])
repeat_year = city_state[rep(row.names(city_state),3),]
repeat_year = sqldf("select * from repeat_year order by State,city")
repeat_year$Date = seq(2013,2015)
repeat_year$Date = as.numeric(repeat_year$Date)
sapply(repeat_year,class)

expand = repeat_year[rep(row.names(repeat_year),21),]
expand = sqldf("select * from expand order by State,city,Date")
expand$Week= seq(1,21)
expand$count=NA

years = data.frame(c(2013,2014,2015))
sapply(years,class)
colnames(years) = "Year"


sapply(subset_ref_fill_in,class)
sapply(expand,class)

expand$count = as.numeric(expand$count)
expand$Date = as.numeric(expand$Date)
expand$Week = as.numeric(expand$Week)

cleaned_data = FillIn(expand,result,Var1 = "count",Var2 = "count",KeyVar = c("Date","city","state","Week"))

cleaned_data[is.na(cleaned_data)] = 0  
cleaned_data$count = as.numeric(cleaned_data$count)
summary(cleaned_data$count)
boxplot(cleaned_data$count)

plot(cleaned_data$count)
assigned_label = cleaned_data
assigned_label$label <-cut(assigned_label$count, seq(1,100,5), right=FALSE, labels=c(1:19))
assigned_label = assigned_label[-5]
assigned_label$label = as.numeric(assigned_label$label)
assigned_label[is.na(assigned_label)] = 0
assigned_label$Date = as.Date(assigned_label$Date)
sapply(assigned_label,class)

write.csv(assigned_label,"analysis_label.csv")
getwd()

set.seed(7355)
trainIndex <- createDataPartition(assigned_label$label, p = .7, list = FALSE, times = 1) 
train.data <- assigned_label[ trainIndex,] 
test.data <- assigned_label[-trainIndex,] 


# new_data_label <- data.table(rbind(train.data,test.data))
# new_data_label <- data.frame(new_data_label)
# sapply(new_data_label,class)
# new_data_label$label = as.character(new_data_label$label)
# new_data_label$label = as.factor(new_data_label$label)
# new_data_label$Week = as.character(new_data_label$Date)
# new_data_label$Week = as.factor(new_data_label$Date)

train.data$label = as.factor(train.data$label)
test.data$label = as.factor(test.data$label)

attach(test.data)
x = subset(test.data,select=-label)
y = label
detach(test.data)

svm_model = svm(label ~ ., data=train.data)
summary(svm_model)
pre = predict(svm_model,x)
l = table(pre, y)
mean(l)
plot(svm_model$fitted)
library(caret)
confusionMatrix(y,pre)

check = data.frame(pre)

xtabs(~ Week+label,data=train.data )
