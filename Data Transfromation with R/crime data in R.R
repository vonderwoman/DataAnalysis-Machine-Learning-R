#getting our directory to work
getwd()
#importing the data set into our environment(R)
#'sep' specifies the column or field separator as a comma
#header line defines the data column names
data<-read.table(
  'crime.csv',
  sep=',',
  header= TRUE,
  stringsAsFactors = TRUE
)
#viewing our dataset
View(data)
print(data)#getting results from the execution part
class(data)#tells us what kind of r object is in the data l
dim(data)#showing us how many rows and columns are in our dataset
head(data)#will print first few rows of our data
tail(data)#will print last few rows 
str(data)#gives us the structure of our data (datatype)
#option to check datatypes of each column in our data set
print(typeof(data$INCIDENT_NUMBER))#datatype for incident_number is int
print(typeof(data$OFFENSE_CODE))
print(typeof(data$OFFENSE_CODE_GROUP))
print(typeof(data$OFFENSE_DESCRIPTION))
print(typeof(data$DISTRICT))
print(typeof(data$REPORTING_AREA))
print(typeof(data$SHOOTING))
print(typeof(data$OCCURRED_ON_DATE))
print(typeof(data$YEAR))
print(typeof(data$MONTH))
print(typeof(data$DAY_OF_WEEK))
print(typeof(data$HOUR))

summary(data)#gives us overall statistics
colnames(data)#checking columns in our data

#########end of  getting overview of our data##############
######checking for missing data############33
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

##########end of project####################

