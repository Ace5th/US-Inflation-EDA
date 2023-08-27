#Analysis Questions:
#1. How does inflation moves over time?
#2. How does COVID-19 affects inflation?

#Install the packages needed
install.packages("ggplot2")
install.packages("dplyr")
install.packages("performance")
install.packages("effects")
install.packages("sjPlot")
library(ggplot2)
library(dplyr)
library(performance)
library(effects)
library(sjPlot)
library(see)
library(patchwork)

#Select the file
getwd()
setwd()
inflation <- read.csv(file = "US_inflation_rates.csv", stringsAsFactors = T)

#Modify the date and extract year from date
inflation$date <- strptime(as.character(inflation$date), "%Y-%d-%m")
inflation$year <- format(as.Date(inflation$date, format="%d/%m/%Y"),"%Y")

#Do the preliminary examination of the dataset
nrow(inflation)
ncol(inflation)
str(inflation)
colSums(is.na(inflation))
summary(inflation)

#Create a new dataframe to summarize the inflation rate per year
avg_inflation_per_year <- inflation %>%
  group_by(year) %>%
  summarize(mean_inflation = mean(value, na.rm = TRUE))

avg_inflation_per_year$year <- as.integer(avg_inflation_per_year$year)

#Trend Analysis of the Inflation
ggplot(data = avg_inflation_per_year, aes(x = year, y = mean_inflation)) +
  geom_point() + geom_line() +
  geom_smooth(method = lm, se = FALSE, color = "blue")