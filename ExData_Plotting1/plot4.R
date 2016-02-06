## Coursera Exploratory Data Analysis Course Project 1

## Check and Downloading Data
if(!file.exists("household_power_consumption.txt")){
    download.file("http://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip",
                  "household_power_consumption.zip")
    unzip("household_power_consumption.zip", overwrite=TRUE)
}

## Reading and Cleaning Data
setwd("C:/Users/shaun.que/desktop/DS")
alldata <- read.table("household_power_consumption.txt", 
                      header=TRUE, 
                      sep=";", 
                      na.strings="?")

alldata$DateTime <- strptime(paste(alldata$Date, alldata$Time), "%d/%m/%Y %H:%M:%S")
alldata$Date <- strptime(alldata$Date, "%d/%m/%Y")

data <- subset(alldata, alldata$DateTime>="2007-02-01" & alldata$DateTime<"2007-02-03")

## Plot 4
png(filename="plot4.png",
    width=480, height=480, units="px", pointsize=12,
    bg="white")

par(mfrow=c(2,2))

## 4.1
plot(data$DateTime, data$Global_active_power, type = "l",
     xlab="", ylab="Global Active Power")

## 4.2
plot(data$DateTime, data$Voltage, type = "l",
     xlab="datetime", ylab="Voltage")

## 4.3
plot(data$DateTime, data$Sub_metering_1, type="n", 
     xlab="", ylab="Energy sub metering")
points(data$DateTime, data$Sub_metering_1, type="l", col="black")
points(data$DateTime, data$Sub_metering_2, type="l", col="red")
points(data$DateTime, data$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1, 
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## 4.4
plot(data$DateTime, data$Global_reactive_power, type = "l",
     xlab="datetime", ylab="Global_reactive_power")

dev.off()