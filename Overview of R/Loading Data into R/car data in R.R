getwd()
#loading data into R
#data is a new data frame 
#filename of the data 'car.data
#'sep' specifies the column or field separator as a comma
#'#header line defines the data column names
#'stringASFactor converts string values to factors.This is default behaviour use this arguement to document
data<-read.table(
    'car.data.csv',
    sep=',',
    header= TRUE,
    stringsAsFactors = TRUE
    )
#examines the data with r's built in tableviewer
View(data)
#print command prints all the data
#this is will give you results in the execution part
print(data)
#class() tells you what kind of r object you hv and it will tell us data is a class data.frame
class(data)
#dim() this command shows how many rows and columns are present in the data
dim(data)
#head() shows the top few rows of the data
head(data)
#str() gives the structure of the data
str(data)
#summary() provides on how the distribution of our data is
summary(data)

  #############end of phase1#################
