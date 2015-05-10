# This file contains the function that will load the required data for the four plot scripts.
# It will only be used if there is no data already available. 
# The alternative to having this separate file would have been to repeat this code in each of 
# the four plot scripts.

PrepData <- function() {
      
      # save source url
      
      fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      
      # download zipped file in temporary file
      temp <- tempfile()
      download.file(fileUrl, temp, method="auto")

      # extract in temporary file
      temp <- unzip(temp)

      # read data in from temporary file
      data <- read.table(temp, header=TRUE, sep=";", colClasses=c("character", "character", "numeric", "numeric", 
                                                                  "numeric", "numeric", "numeric", "numeric", 
                                                                  "numeric"), na.strings="?")
      # get rid of temporary file
      unlink(temp)

      # convert time and date column data to right formats
      data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
      data$Date <- as.Date(data$Date, "%d/%m/%Y")

      # extract subset with the two wanted dates and get it out for plotting
      dataset <<- data[data$Date %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")),]
      
}
