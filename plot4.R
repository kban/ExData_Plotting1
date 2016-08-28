library(plyr)
library(data.table)

directory <- "Data"
if (!file.exists(directory)) {
  # Download the archive if it not exists
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  tmp_file <- "./temp.zip"
  download.file(url,tmp_file)
  # Unzip downloaded archive
  unzip(tmp_file, exdir="./Data")
  unlink(tmp_file)
}

filePath <- paste(directory, "household_power_consumption.txt", sep="/")

# Getting Data for dates 1/2/2007 - 2/2/2007
fullData = read.table(filePath, skip = grep("1/2/2007", readLines(filePath)) - 1, nrows = 2881, sep = ';')

names(fullData) <- c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')

fullData$Datetime <- strptime(paste(fullData$Date, fullData$Time, sep=" "),'%d/%m/%Y %H:%M:%S')

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(fullData, {
  plot(Datetime, Global_active_power, type = "l", 
       ylab = "Global Active Power", xlab = "")
  plot(Datetime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
  plot(Datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering",
       xlab = "")
  lines(Datetime, Sub_metering_2, col = 'Red')
  lines(Datetime, Sub_metering_3, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
         bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Datetime, Global_reactive_power, type = "l", 
       ylab = "Global_rective_power", xlab = "datetime")
})


dev.off();


