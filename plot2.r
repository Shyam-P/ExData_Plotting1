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

# Convert date & time to a number for plotting on x-axis
# First create single string, then map using strptime and finally coerce as numeric
# Add as a new column called DateTime
DT2$DateTime=as.numeric(strptime(paste(DT2$Date,DT2$Time,sep="_"),"%d/%m/%Y_%H:%M:%S"))

# Open graphics device for png output
png(filename="plot2.png", width=480, height=480)

# Generate plot which is a line type plot. Set other attributes too.
plot(DT2$DateTime, DT2$Global_active_power,
     type="l",
	 xlab="",
	 ylab="Global Active Power (kilowatts)")

# TODO: Change X axis ticks to Thu, Fri and Sat marking start of each day

# Close the png file
dev.off()
