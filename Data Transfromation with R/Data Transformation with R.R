#checking working directroy
getwd()
library(dplyr)
#loading the data into R
median_income_table <-
  readRDS("median_income.RDS")
#viewing first few rows
head(median_income_table)
#joining the income table to the customer data
#note that both data should be in the same folder
training_prepared <- training_prepared %>%
  left_join(., median_income_table, by="state_of_res") %>%
  mutate(income_normalized = income/median_income)
#compare the values of income and income_normalized
head(training_prepared[, c("income", "median_income", "income_normalized")])
#getting the summary of income_normalized column
summary(training_prepared$income_normalized)
#we did a conditional transformation
#observation:customers with an income higher than the median income of their state have an income_normalized value larger than
#1, and customers with an income lower than the median income of their state have an
#income_normalized value less than 1


#####normalizing by mean age
summary(training_prepared$age)

mean_age <- mean(training_prepared$age)
age_normalized <- training_prepared$age/mean_age
summary(age_normalized)
#observation A value for age_normalized that is much less than 1 signifies an unusually young customer; 
#much greater than 1 signifies an unusually old customer

######centering and scaling#########3333
#in a scenario where A customer who is within one standard deviation of the mean age is considered not much older or younger than typical.
#A customer who is more than one or two standard deviations from the mean can be considered much older, or much younger
#centering and scaling age

(mean_age <- mean(training_prepared$age))#takes the mean
(sd_age <- sd(training_prepared$age))#take the standard deviation
print(mean_age + c(-sd_age, sd_age))
#observation:takes age range for this population about 31 to 67 age

#use the mean value as reference point and rescales the distance from the mean by the standard deviation
training_prepared$scaled_age <- (training_prepared$age -
                                   mean_age) / sd_age
training_prepared %>%
  filter(abs(age - mean_age) > sd_age) %>%
  select(age, scaled_age) %>%
  head()

#centering and scaling muiltiple numeric variables
#creating dataframe dataf
dataf <- training_prepared[, c("age", "income", "num_vehicles", "gas_usage")]
summary(dataf)
#centering the data by its mean and scales it by its standard deviation
dataf_scaled <- scale(dataf, center=TRUE, scale=TRUE)
summary(dataf_scaled)
#get the means and std of the original data which are stored in dataf_scaled
(means <- attr(dataf_scaled, 'scaled:center'))

(sds <- attr(dataf_scaled, 'scaled:scale'))
###########end of data transformation################



