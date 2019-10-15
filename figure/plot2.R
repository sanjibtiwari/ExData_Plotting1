
rm(list=ls())
gc()

# Loading Packages
library(dplyr) #Data wranling
library(lubridate) # working with dates



setwd("E:\\R learning\\coursera") # setting up working directory

# First calculate a rough estimate of how much memory the dataset will require in memory before reading into R. 
# Make sure your computer has enough memory (most modern computers should be fine).
memory.size(max=TRUE)
object.size(read.delim("E:\\R learning\\coursera\\household_power_consumption.txt", header=TRUE, sep=";"))

# reading the data
power_data<-read.delim("household_power_consumption.txt", header=TRUE, sep=";")

# The dataset has 2,075,259 rows and 9 columns. 
dim(power_data)

#filtering out the data not used in EDA
power_data<- filter(power_data, Date=="1/2/2007" | Date=="2/2/2007")

# Looking ar the first few observations
head(power_data)

# checking the date class

class(power_data$Date)

# This is a factor class

# Converting the factor class to a Date Class using the lubridate package

power_data$Date_Time<- paste(power_data$Date,power_data$Time, sep=" ")
power_data$Date_Time<-dmy_hms(power_data$Date_Time)
class(power_data$Date_Time)

#converting all the variables to numeric class. The variables are listed from column 3 to 9. R applies some funky logic
# when converting factors to numeric. The way to proceed is to convert factors to characters to numeric
power_data[,3:9]<-lapply(power_data[,3:9], function(x) as.numeric(as.character(x)))


str(power_data) # checking if all the variables are in the correct format or not

png(filename="plot2.png",width=480, height=480, units="px") # setting up the graphics device
# making the plot
plot(power_data$Date_Time,power_data$Global_active_power,
     type='l',
     lwd=1,
     ylab= "Global Active Power (kilowatts)",
     xlab= ""
)


dev.off() # turning the graphics device off





