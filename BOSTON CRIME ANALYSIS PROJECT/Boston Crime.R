#getting our directory to work
getwd()
#importing packages to be used in the data
library(tidyr)#this package will help you tidy your data:tidy the columns where each variable is present in a column
library(scales)#with the help of scale we can automatically map the data to the correct scaes with well-placed axes and legends
library(ggplot2)#for data visualization
library(tidyverse)#for data manipulation
install.packages("data.table")
library(data.table)#help reading our data into R environment
data <- fread("crime.csv")
################understanding our data###################3333
print(data)#printing our data on the console
view(data)#viewing our data
nrow(data)#counting the number of rows in our data
class(data)#tells us what kind of r object is in the data 
dim(data)#showing us how many rows and columns are in our dataset
head(data)#will print first few rows of our data
tail(data)#will print last few rows 
str(data)#gives us the structure of our data (datatype)
#option to check datatypes of each column in our data set
print(typeof(data$INCIDENT_NUMBER))#datatype for incident_number is int
print(typeof(data$OFFENSE_CODE))#datatype for offense_code
print(typeof(data$OFFENSE_CODE_GROUP))#datatype for offense_code_group
print(typeof(data$OFFENSE_DESCRIPTION))#datatype for offense_description
print(typeof(data$DISTRICT))#datatype for district
print(typeof(data$REPORTING_AREA))#datatype for reporting_area
print(typeof(data$SHOOTING))#datatype for shooting
print(typeof(data$OCCURRED_ON_DATE))#datatype for occurred_on_date
print(typeof(data$YEAR))#datatype for year
print(typeof(data$MONTH))#datatype for month
print(typeof(data$DAY_OF_WEEK))#datatype for day_of_Week
print(typeof(data$HOUR))#datatype for hour
summary(data)#gives us overall statistics
colnames(data)#checking columns in our data

########handling missing data############################
# is.na() functions you can find the number of missing values in your data
is.na(data)
sum(is.na(data))#we have about 31760 numbers that are missing
sum(is.na(data$INCIDENT_NUMBER))#identifying missing values per column
sum(is.na(data$OFFENSE_CODE))#identifying missing values per column
sum(is.na(data$OFFENSE_CODE_GROUP))#identifying missing values per column
sum(is.na(data$OFFENSE_DESCRIPTION))#identifying missing values per column
sum(is.na(data$DISTRICT))#identifying missing values per column
sum(is.na(data$REPORTING_AREA))#identifying missing values per column
sum(is.na(data$SHOOTING))#identifying missing values per column
sum(is.na(data$OCCURRED_ON_DATE))#identifying missing values per column
sum(is.na(data$STREET))#identifying missing values per column
sum(is.na(data$Lat))#identifying missing values per column
sum(is.na(data$Long))#identifying missing values per column
sum(is.na(data$Location))#identifying missing values per column
#observation,no missing values in our data
#we can also use this method
count_missing=function(df){#defines a function that counts the number of NAs in each column of a dataframe
  sapply(df,FUN=function(col)sum(is.na(col)))
}
#applying this to our data
nacounts <- count_missing(data)
hasNA = which(nacounts > 0)#applies the function to our crime data and identify which columns have missing values,and prints the columns and counts
nacounts[hasNA]
#####removing the nan values or columns from our dataset
data[is.na(data)] <- 0
#testing to see if this worked
sum(is.na(data$Long))#this column had nan and when we run it we observe that nan is not there
sum(is.na(data$Lat))
sum(is.na(data$REPORTING_AREA))


length(unique(data$INCIDENT_NUMBER))#to count unique incident_number
length(unique(data$INCIDENT_NUMBER)) == nrow(data)##checking for duplicate values


#after cleaning our data, we need to visualize how the data looks and its distribution
#we will start first with some statistical distribution
min(data$OCCURRED_ON_DATE)
max(data$OCCURRED_ON_DATE)
summary(data$INCIDENT_NUMBER)
summary(data$OFFENSE_CODE)
summary(data$OFFENSE_CODE_GROUP)
summary(data$YEAR)

########univariate feature analysis###############
#creating a histogram for District column
ggplot(data,aes(x=DISTRICT)) +geom_bar(fill="purple")
#observation we can see that B2 has the highest value and A15 had the lowest values
#note on the graph there is a column without label because we converted the empty values in column to 0 thats why there is a bar without values
#creating histogram for hour column
ggplot(data,aes(x=HOUR)) +geom_bar(fill="green")
#observation: this looks like a discrete bar graph, but this is a continuous feature
ggplot(data, aes(x = HOUR)) +
  geom_histogram(aes(y = ..density..),  colour= "black", fill = "green") +
  geom_density(fill="blue", alpha = .2) 
#observation:we can infer that crime rates are highest from 16:00 to 20:00 hour and 
#again we can see some rise in crime rates at midnight 00:00 hours
#we can create a hypotheses that each year will have similar distribution

############Multivariate Feature Analysis##################33
#analyzing more than one feature at a time
#here, we are trying to see if techniques like regression analysis,cluster analysis and correlation analysis
#SCENARIO:There can be a case where the highest crime rated district will change from year to year

colors = c(""#CC1011", "#665555", "#05a399", "#cfcaca", "#f5e840", "#0683c9", "#e075b0"")
           
YEAR_DISTRICT_group <- data %>%
  group_by(DISTRICT, YEAR) %>%
  dplyr::summarize(Total = n())

ggplot(YEAR_DISTRICT_group, aes(DISTRICT, Total, fill = YEAR)) + 
  geom_bar( stat = "identity") +
  ggtitle("Distribution") +
  scale_y_continuous(labels = comma) 
#observation on 2015-2016 we can see there is a spike of crime
#and there is a decrease by 2019
ggplot(YEAR_DISTRICT_group, aes(YEAR, Total, fill = DISTRICT)) + 
  geom_bar( stat = "identity") +
  ggtitle("Distribution") +
  scale_y_continuous(labels = comma)
################end of project########################
