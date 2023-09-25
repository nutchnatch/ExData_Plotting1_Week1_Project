library(lubridate)
library(tidyverse)
library(magrittr)

# Check if folder data exists. If not, creates it.
if(!file.exists('data')) {
  dir.create('data')
}

# Download zip source file, if not existent
#if(!file.exists('./data/power_consumption.zip')) {
#  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./data/power_consumption.zip")
#}

# Unzip file if not existent
#if(!file.exists("./data/household_power_consumption.txt")) {
#  unzip(zipfile = "./data/power_consumption.zip", exdir = './data', list = FALSE, overwrite = TRUE)
#}


# Load data into a variable data_set 
data_set <- read.table(file = "./data/household_power_consumption.txt",
                       header = TRUE,
                       sep = ';',
                       stringsAsFactors = FALSE ,
                       na.strings = "?",
                       nrows = 2075259, 
                       check.names = FALSE,
                       colClasses = c(character(),
                                      character(),
                                      numeric(),
                                      numeric(),
                                      numeric(),
                                      numeric(),
                                      numeric(),
                                      numeric(),
                                      numeric()))


filtered_tidy_data <- data_set %>%
  #Merge date and time
  mutate(Time = strptime(paste(Date, " ", Time), "%d/%m/%Y %H:%M:%S")) %>%
  #Transform to date format
  mutate(Date = as.Date(Date, "%d/%m/%Y")) %>%
  #Filter dte range
  filter(Date >= "2007-02-01" & Date <= "2007-02-02")

#Configure the png file to be created with the plot content
png(filename = "./plot4.png", width = 480, height = 480, units = "px", bg = "white")
Sys.setlocale("LC_TIME", "English")

#Configure the plot for " rows and two columns, each cell will contain a plot
par(mfrow = c(2, 2))

# Top-left
plot(x = filtered_tidy_data$Time,
     y = filtered_tidy_data$Global_active_power ,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

## Top-right
plot(x = filtered_tidy_data$Time,
     y = filtered_tidy_data$Voltage ,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

## Bottom-left
plot(x = filtered_tidy_data$Time,
     y = filtered_tidy_data$Sub_metering_1,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")

lines(x = filtered_tidy_data$Time, 
      y = filtered_tidy_data$Sub_metering_2, 
      type = "l", 
      col = "red")

lines(x = filtered_tidy_data$Time, 
      y = filtered_tidy_data$Sub_metering_3, 
      type = "l",
      col = "blue")

legend(x = "topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       lwd = 2.5,
       col=c("black", "red", "blue"),
       bty="n")

## Bottom-right
plot(x = filtered_tidy_data$Time,
     y = filtered_tidy_data$Global_reactive_power,
     type = "l",
     col = "black",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()