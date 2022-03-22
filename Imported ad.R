# ADVERTISING DF

## Define the question
The question is making conclusion on who is likely to click on the ads or not. 
## Metric for success

In order to work on the above problem, you need to do the following:
  
  -   Define the question, the metric for success, the context, experimental design taken and the appropriateness of the available data to answer the given question.

-   Find and deal with outliers, anomalies, and missing data within the dataset.

-   Perform univariate and bivariate analysis.

-   From your insights provide a conclusion and recommendation.


## Data Understanding (the context)

A Kenyan entrepreneur has created an online cryptography course and would want to advertise it on her blog. She currently targets audiences originating from various countries. In the past, she ran ads to advertise a related course on the same blog and collected data in the process. She would now like to employ your services as a Data Science Consultant to help her identify which individuals are most likely to click on her ads.

In order to work on the above problem, you need to do the following:
  
  -   Define the question, the metric for success, the context, experimental design taken and the appropriateness of the available data to answer the given question.

-   Find and deal with outliers, anomalies, and missing data within the dataset.

-   Perform univariate and bivariate analysis.

-   From your insights provide a conclusion and recommendation.

## Experimental design

1.  Import the data to R
2.  Perform data exploration
3.  Define metrics for success
4.  Perform Univariate and Bivariate data Analysis
5.  Provide conclusion


ad <- read.csv("advertising.csv")
# View my data
head(ad)
tail(ad)

# Finding the Shape of the dataset
dim(ad)

# Finding the datatypes of the dataset
str(ad)

## Data cleaning

# checking for missing Data
colSums(is.na(ad))

# There are no missing values in our datasets
```

# Check for duplicated data in the ad
ad1 <- ad[duplicated(ad),]
ad1

# There are no duplicate values.
```{r}
str(ad)
boxplot(ad$Daily.Time.Spent.on.Site, main = 'Daily Time Spent on-site')
boxplot(ad$Age, main = 'Age Boxplot')
boxplot(ad$Area.Income, main = 'Area Income Boxplot')
boxplot(ad$Daily.Internet.Usage, main = 'Daily Internet usage boxplot')

From the boxplots, only the Area_income column has outliers. 

````
#Print out the outliers 
boxplot(ad$Area.Income, main = 'Area Income Boxplot')$out

There are outliers that do not look like they are in the extreme. There are areas where poverty is prevelant in such areas the total income could be that small.


```{r}
str (ad)


```{r}
ad[['Timestamp']] <- as.POSIXct(ad[['Timestamp']],
                                   format = "%Y-%m-%d %H:%M:%S")
str(ad)

The timestamp column is now in the correct dtype

````

## Univariate Data Analysis

###Numerical Columns
```{r}
summary(ad)

```

#### Age 
```{r}
# Mean 
mean.age <- mean(ad$Age)
mean.age

```
# Function to get the mode. 
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

```
####Area income 
```{r}
mean.areaincome <- mean(ad$Area.Income)
mean.areaincome

```
hist(ad$Area.Income,
     main="Histogram for Area Income", 
     xlab="Area income", 
     border="blue", 
     col="steelblue",)

```
#### Daily time spent on site

```{r}
mean.dtsos <- mean(ad$Daily.Time.Spent.on.Site)
mean.dtsos

````

mode.dtsos <- getmode(ad_df$Daily.Time.Spent.on.Site)
mode.dtsos

```
#### Clicked.on.Ad
```{r}
uniq_clickers <- unique(ad$Clicked.on.Ad, )
length(uniq_clickers)

There are two categories of the people who clicked on ads

````
Let us plot the frequency of each
```
clickers <- ad$Clicked.on.Ad
clickers_frequency <- table (clickers)
barplot(clickers_frequency, col = "steelblue")

# There are 500 people who clicked on ads and another 500 did not click on the ads. 

````

### Categorical Columns
####Ad.Topic.line
```
uniq_topic <- unique(ad$Ad.Topic.Line, )
length(uniq_topic)
```
# There are 1000 unique topic lines meaning it would be impossible to get a good visualization. 

````
#### Country 
```
uniq_country <- unique(ad$Country)
length(uniq_country)

```
# There are 237 unique countries. 

````
library(sf)
library(raster)
library(dplyr)
library(spData)
#library(spDataLarge)
library(tmap)
library(leaflet) 
library(ggplot2)

````

Country <- ad$Country
countyfreq <- table(Country)

````

hist(ad$`Age`, xlab = "Age")
#An even spread on time spent on site

````
hist(ad$`Male`, xlab = "Male")

````
age <- ad$Age
ages <- table(Age)
barplot(ages, xlab = "Male")
#The age distribution

````

## Bivariate Analysis

# Lets find the covariance between a variety of the features 
```

daily <- ad$`Daily Time Spent on Site`
age <- ad$Age
income <- ad$`Area Income`
sex <-ad$Male
use <- ad$`Daily Internet Usage`
click <- ad$`Clicked on Ad`
cov(daily,click)
#That has a negative correlation

````
## checking correlation matrix
```
num_ads <- unlist(lapply(ad, is.numeric))
num_ad <- ad[ , num_ads]
cor(num_ad)

````

## Ploting age against clicks

```
plot(click,age, xlab ="## Ploting age against clicks


(click,age, xlab = "Clicked on Ad", ylab = "The ones who clicked")

#The graph inst the best visual
```
### only the ones with postive correlations

cor(age,click)

#a medium postive correlation 

````
#### Correlation

```{r}
#creating with only interger columns
numerical_df = ad_df[c("Daily.Time.Spent.on.Site", "Age", "Area.Income","Daily.Internet.Usage" ,"Male", "Clicked.on.Ad" )]
head(numerical_df)

````

correlation = cor(numerical_df)
correlation

````

## Conclusion

From the analysis we can get several deductions:
- The mean Age of the population is 36, and as the age increased more people clicked on ads. 
- There is an inverse relationship between the daily time spent on site and the number of people who click the ads
- The gender of the users had the least effect on the number of ads clicked and barely affected any other variables.