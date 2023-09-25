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
png(filename = "./plot2.png", width = 480, height = 480, units = "px", bg = "white")
Sys.setlocale("LC_TIME", "English")
#Create the histogram and export the file
plot(filtered_tidy_data$Time, filtered_tidy_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kW)")
dev.off()
