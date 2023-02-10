#checking the working directory
getwd()
#loading the file data into R
#creating a dataframe know us customer_data and assigning all the file to it
customer_data =readRDS("custdata.RDS")
#getting the summary of the data
summary(customer_data)
#lets take a quick look at income column
#note that the -ve values from income could indicate bad data
summary(customer_data$income)
#summary of age column
#the zero min we got from running the age column could mean age unknown
summary(customer_data$age)
#Visualizng this data can help us get insight about the data
#the visualization will help you to idnetify the peak value of the distribution
#how normal(lognormal)is the data
#how much does the data vary
#importing library
library(ggplot2)
ggplot(customer_data, aes(x=gas_usage)) + 
  geom_histogram(binwidth=10, fill="gray") 
#one thing we can capture from the above visual is the shape of the distribution
#observations:
#1) you will notice high counts of gas payments in $0-10 range
#this range could also mean the most customer dont have heaters
#but also the ranges if you notice are from 001 to 003
#before making wrong conclusion convert those numbers to NA
#next, produce a density plot graph for the outcome
library(scales)#scale package brings the dollar scale notation
ggplot(customer_data,aes(x=income))+
  geom_density()+ scale_x_continuous(labels=dollar)#setting the x axis to dollar
#observations:their a heavly mass distribution in one side
#note most of the distribution is below $200,000
#from above $200,000 we can see flatening in our graph
#here it is difficult to know or tell exact value where the income distribution has its peak
#lets gragh a logarithms scale to get more clear values
ggplot(customer_data,aes(x=income))+
  geom_density()+
  scale_x_log10(breaks=c(10,100,1000,10000,100000,1000000),#set the x axis to log10,with tick and labels as dollar
                labels=dollar)+
  annotation_logticks(sides="bt",color="gray")
#When you issue the preceding command, you also get back a warning message:
  ## Warning in self$trans$transform(x): NaNs produced
  ## Warning: Transformation introduced infinite values in continuous x-axis
  ## Warning: Removed 6856 rows containing non-finite values (stat_density).
# this will mean that ggplot2 ignored the zero- and negative-valued rows (since log(0)= Infinity), and that there were 6856 such rows
  #observation is that the income range is distributed normally   
#plotting the marital status from our customer data
ggplot(customer_data, aes(x=marital_status)) + geom_bar(fill="gray")
#obervation:married customers are high and the widowed are low 

# Plotting horizontal bar chart
ggplot(customer_data, aes(x=state_of_res)) +
  geom_bar(fill="gray") +
  coord_flip()#here we flipped the state_of _res column to be on the y-axis
#observation:california is higher on the graph

#plotting the same state_of_res column using dot plot
#Cleveland also recommends that the data in a bar chart or dot plot be sorted, to more efficiently extract insight from the data. 
#install this package 
install.packages("WVPlots")
library(WVPlots)
ClevelandDotPlot(customer_data, "state_of_res",
                 sort = 1, title="Customers by state") +
  coord_flip()
#the same result but easier insight where california is high and wyoming is low in the graph

##visually checking for any relationships in our data
#is there a correlation between icome and age?
#therefore use line plot and scatter plot to see the types of relation in our data
#creating a subset of our data
customer_data2 <- subset(customer_data,
                         0 < age & age < 100 &
                           0 < income & income < 200000)
#getting the correlation of age and income
cor(customer_data2$age, customer_data2$income)
#observation:the correlation is positive and its nearly zero
#this means there is minimum correlation between age and income

###lets try to use a scatter plot to get more insights

##make the random sampling reproducible by setting the random seed
set.seed(245566)
customer_data_samp<-
  dplyr::sample_frac(customer_data2,size=0.1,replace=FALSE)#plotting only 10% sample of the data
#creating the scatterplot now
ggplot(customer_data_samp, aes(x=age, y=income)) +
  geom_point() +
  ggtitle("Income as a function of age")
#observation:the relation between the income and age isnt much seen 
#for clear correlation use a smoothing curve 
ggplot(customer_data_samp, aes(x=age, y=income)) +
  geom_point() + geom_smooth() +
  ggtitle("Income as a function of age")
#Observations
#1)income tends to increase with age from a person's twenties until their mid-thirties
#2)from mid-thirties,the income increases at a slower rate until mid-fifties
#3)after mid-fifties,we can see the income decreases hence income tend to decrease with age

#producing a hexbin plot of income and age
#load the wvplots library
#install the hexbin 
install.packages("hexbin")
HexBinPlot(customer_data2, "age", "income", "Income as a function of age") +
  geom_smooth(color="black", se=FALSE)#suppresses standard error ribbon(se=false)

#lets try to see if there is another relation between marital status and health insurance coverage
ggplot(customer_data, aes(x=marital_status, fill=health_ins)) +
  geom_bar()#stacked bar chat plot
#observation:we can see more customers have been insured
#this stacked bar chat makes us see the different between insured and not insured

ggplot(customer_data, aes(x=marital_status, fill=health_ins)) +
  geom_bar(position = "dodge")#side by side bar chart

ShadowPlot(customer_data, "marital_status", "health_ins",
           title = "Health insurance status by marital status")#using shawdow plot


ggplot(customer_data, aes(x=marital_status, fill=health_ins)) +
  geom_bar(position = "fill") using the filled barplot()


###plotting a bar chat with and without facet
#creating a new data frame called cdata and assigning all the  values into it
cdata <- subset(customer_data, !is.na(housing_type))#restricts to the data where housing_type isknown
ggplot(cdata, aes(x=housing_type, fill=marital_status)) +
  geom_bar(position = "dodge") +
  scale_fill_brewer(palette = "Dark2") +
  coord_flip()#side by side bar chart
#used flip() to rotate the graph so that marital_status is legible

ggplot(cdata, aes(x=marital_status)) +
  geom_bar(fill="darkgray") + #plotting faceted bar chart
  facet_wrap(~housing_type, scale="free_x") +
  coord_flip()#flip() argument to rotate the graph
#facets the graph by housing.type.The scale="free_x" argument specifies that each facet has an independent csaled x axis
#arguement free-y will free the y axis

##comparing two populations from our data
##compare the age distribution of the widowed population skews older, and the never married population skews younger
customer_data3 = subset(customer_data2, marital_status %in%
                          c("Never married", "Widowed"))#restricting to never married and widowed column
ggplot(customer_data3, aes(x=age, color=marital_status,#differetiates the color and line style of the plots by marital_Status
                           linetype=marital_status)) +
  geom_density() + scale_color_brewer(palette="Dark2")
#overlaid density gives you a good information about distribution shape
#lets plot histogram to get more details
ShadowHist(customer_data3, "age", "marital_status",
           "Age distribution for never married vs. widowed populations", binwidth=5)#setting the bin widths of the histogram
#observation:you can see the widowed population is quite small and it doesnt exceed the never married population
##at the age of 65 we can see that population rises than the marital since marital population decreases after 60
#note that you should use faceting when comparing distributions across more than two categories.

##tryig to examine all the four categories of marital status using density line
ggplot(customer_data2, aes(x=age)) +
  geom_density() + facet_wrap(~marital_status)



####################3end of data exploration project#################################
####################################################################################
