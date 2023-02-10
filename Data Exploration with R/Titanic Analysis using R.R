#checking our working directory
getwd()
#importing packages to be used in the data
library(tidyr)#this package will help you tidy your data:tidy the columns where each variable is present in a column
library(scales)#with the help of scale we can automatically map the data to the correct scaes with well-placed axes and legends
library(ggplot2)#for data visualization
library(tidyverse)#for data manipulation
install.packages("data.table")
library(data.table)#help reading our data into R environment
data <- fread("Titanic.csv")
##############understanding our dataset
View(data)#This helps us in familiarising with the data set
head(data)
tail(data)#In order to have a quick look at the data, we often use the head()/tail().
names(data)#This helps us in checking out all the variables in the data set.
class(data)
str(data)#This helps in understanding the structure of the data set, data type of each attribute and number of rows and columns present in the data.
summary(data)
#In case we just need the summary statistic for a particular variable in the dataset, we can use
summary(data$Survived)

################Analysis and Visualization#################################
#What was the survival rate?
ggplot(data, aes(x=Survived)) + geom_bar()
#observation:On the X-axis we have the survived variable,
#0 representing the passengers that did not survive, 
#and 1 representing the passengers who survived. 
#The Y -axis represents the number of passengers. Here we see that over 550 passenger did not survive and ~ 340 passengers survived.
#lets make it more clearer
prop.table(table(data$Survived))
#observation:38.34% did survive
#62% didnt survive

#Survival rate basis Gender
Sex_Survived_group <-data %>%
  group_by(Survived,Sex) %>%
  dplyr::summarize(Total =n())

ggplot(Sex_Survived_group,aes(x=Sex,Total,fill=Survived)) +
  geom_bar(stat = "identity") +
  labs(y="Number of Passenger",
       title="Survival Rate by Gender")
#observation:survival rate for women were significantly higher when compared to men

#Survival Rate based class of tickets
Pclass_Survived_group <-data %>%
  group_by(Survived,Pclass) %>%
  dplyr::summarize(Total =n())

ggplot(Pclass_Survived_group,aes(x=Pclass,Total,fill=Survived)) +
  geom_bar(stat = "identity") +
  labs(y="Number of Passenger",
       title="Survival Rate by Passenger class")
#observation 1st class had more passengers who survived
#2nd class had about 45-50% who survived
#3rd class we see many passengers did not survive and a few survived

###########end of project#####################