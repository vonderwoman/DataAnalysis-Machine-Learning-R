# BOSTON CRIME ANALYSIS
Boston crime dataset5 is a collection of crime incident reports that are provided by the Boston Police Department (BPD). This dataset documents the initial details surrounding an incident to which BPD officers respond

# Overview of our Data
Field Name, Data Type [incident_num] [varchar] (20) NOT NULL, [offense_code] [varchar] (25) NULL, [Offense_Code_Group_Description] [varchar] (80) NULL, [Offense_Description] [varchar] (80) NULL [district] [varchar] (10) NULL [reporting_area] varchar NULL, [shooting][char] (1) NULL, [occurred_on] datetime2 NULL, [UCR_Part] varchar NULL, [street] varchar NULL,

# Objectives
This project will mostly focus on the data visualization techniques. I will also cover some basics of Data Exploring and how to implement some techniques for data cleaning as well. O.S.E.M.N Framework will be used O.S.E.M.N. (Obtaining, Scrubbing, Exploring, Modeling, Interpreting)

# Data Obtaining
This involves all steps to gather data . After downloading data, we need to load into R studio and store it in a dataframe.
# Data scrubbing
It is a process of cleaning the data which will be fit for use in the next stage that is Data Exploration and Analysis. In this phase, we will focus in handling missing values, errors and cleaning them to prepare for the next phase. Before we start with cleaning our data, we have to understand and know what kind of a data we are dealing with.The best way to understand our data is by the following:

Then the next step is by handling errors and missing values

Note: Handling missing values from the data will improve the quality of the data we are using, and in turn, it will yield accurate analysis.
# Exploring
Data Exploring is a combination of Art and Science. We need to ask the right kind of question and use the right tool to analyze the results. I divided this project into the following categories

# Univariate Feature Analysis
a. Distribution
b. Anomaly or Outlier Detection

# Multivariate Feature Analysis
a. Correlation 
b. Dependence

Univariate Feature Analysis As the name suggests, dealing with one feature at a time. we need to visualize how the data looks and is distributed among the dataset.

Multivariate feature Analysis It refers to analyzing more than one feature at a time. SCENARIO: There can be a case where the highest crime rated district will change from year to year

# Conclusion
We have mostly covered the concepts of O.S.E.M.N. framework and some of the basic techniques to handle the dataset.
