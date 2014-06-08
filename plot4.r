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
DT1$Voltage=as.numeric(DT1$Voltage)
DT1$Global_reactive_power=as.numeric(DT1$Global_reactive_power)

# Get complete cases (drop NAs)
good<-complete.cases(DT1)
DT2<-DT1[good,]

# Convert date & time to a number for plotting on x-axis
# First create single string, then map using strptime and finally coerce as numeric
# Add as a new column called DateTime
DT2$DateTime=as.numeric(strptime(paste(DT2$Date,DT2$Time,sep="_"),"%d/%m/%Y_%H:%M:%S"))

# Open graphics device for png output
png(filename="plot4.png", width=480, height=480)

# Set the plot as a 2x2 layout
par(mfrow=c(2,2))

# Generate the first plot
plot(DT2$DateTime, DT2$Global_active_power,
     type="l",
	 xlab="",
	 ylab="Global Active Power (kilowatts)")
	  
# Generate the second plot
plot(DT2$DateTime, DT2$Voltage,
     type="l",
	 xlab="datetime",
	 ylab="Voltage")
	  
# Generate the third plot
 plot( DT2$DateTime, DT2$Sub_metering_1, 
       type="n", 
	   xlab="", ylab="Energy sub metering")
lines(DT2$DateTime, DT2$Sub_metering_1)
lines(DT2$DateTime, DT2$Sub_metering_2, col="red")
lines(DT2$DateTime, DT2$Sub_metering_3, col="blue")
legend( "topright", 
        pch = 1, # TODO: Need to set this to correct style code
        col=c("black", "red", "blue"), 
		legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
		
# Generate the fourth plot
plot(DT2$DateTime, DT2$Global_reactive_power,
     type="l",
	 xlab="datetime",
	 ylab="Global_reactive_power")


	   
# TODO: Change X axis ticks to Thu, Fri and Sat marking start of each day

# Close the png file
dev.off()
