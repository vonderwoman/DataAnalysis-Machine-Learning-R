#check you working directory
getwd()
#loading the data into a new data frame d
d<-read.table('german.data',
              sep="",
              stringsAsFactors = FALSE, header= FALSE )
#rearranging cols name to the appropriate below
colnames(d)<-c('Status_of_existing_checking_account','Duration_in_month',
               'Credit_history','Purpose','Credit_amount','Savings_account_bonds',
               'Present_employment_since',
               'Installment_rate_in_percentage_of_disposable_income',
               'Personal_status_and_sex', 'Other_debtors_guarantors',
               'Present_residence_since', 'Property', 'Age_in_years',
               'Other_installment_plans', 'Housing',
               'Number_of_existing_credits_at_this_bank', 'Job',
               'Number_of_people_being_liable_to_provide_maintenance_for',
               'Telephone', 'foreign_worker', 'Good_Loan')
#viewing the dataframe in my data
str(d)
#summary(d)
summary(d)

