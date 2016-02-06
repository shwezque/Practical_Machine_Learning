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

## Plot 1
png(filename="plot1.png",
    width=480, height=480, units="px", pointsize=12,
    bg="white")

hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", 
     xlim=c(0,6), ylim=c(0,1200), breaks=13,
     col="red")

dev.off()