#
# R file from P. Shyamasunder (p.shyamasunder@gmail.com)
# written as part of the Course Project 1 for Exploratory Data Analysis course (Week 1)
#

# This is the first file plot1.R which should be run with the input 
# data file "household_power_consumption.txt" located in the current directory 


# First read the data file.
library(data.table)
DT=fread("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")
DT1=DT[DT$Date=="1/2/2007"|DT$Date=="2/2/2007"]

# Notes:
# 1. Though fread() provides the fastest way to read the file, it converts all columns
#    as of type "character", even though it is provided with an appropriate "colClasses" argument.
#    Workaround for now: read data, subset it and then coerce type of columns as necessary.

# Convert class of numeric columns of interest
DT1$Global_active_power=as.numeric(DT1$Global_active_power)
DT1$Global_reactive_power=as.numeric(DT1$Global_reactive_power)
DT1$Sub_metering_1=as.numeric(DT1$Sub_metering_1)
DT1$Sub_metering_2=as.numeric(DT1$Sub_metering_2)
DT1$Sub_metering_3=as.numeric(DT1$Sub_metering_3)

# Get complete cases (drop NAs)
good<-complete.cases(DT1)
DT2<-DT1[good,]

# Open graphics device for png output
png(filename="plot1.png", width=480, height=480)

# Generate first plot which is a histogram of Global_active_power
# Attributes to be updated are X label, title and color.
hist( DT2$Global_active_power, 
      xlab = "Global Active Power (kilowatts)", 
	  main = "Global Active Power",
	  col = "red")

# Close the png file
dev.off()
