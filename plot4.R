# create four plots in one file 
# first (top left): global active power across the two days
# second (top right): voltage across the two days
# third (bottom left): energy sub metering 1-3 across the two days, color-coded
# fourth (bottom right): global reactive power across the two days


plot4 <- function(){
      # first get data, but only if necessary - it is checked whether there is an object 
      # called dataset. If there is, 
      # the plot is created using the existing dataset-object, if not it is recreated
      if(!exists("dataset")){
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
      
      # prepare file to put graphic in, explicitly mentioning the size (identical to default though)
      png(filename = "plot4.png", width = 480, height = 480)
      
      # produce graphs to put in png-file
      # set margins and prepare layout of file to accommodate four graphs
      par(mar = c(5, 4, 4, 2))
      par(mfrow = c(2, 2))
      # create first plot 
      plot(dataset$Time, dataset$Global_active_power, type = "l", 
           ylab = "Global Active Power", xlab = "")
      # create second plot
      plot(dataset$Time, dataset$Voltage, type = "l",
           ylab = "Voltage", xlab = "datetime")
      # create third plot
      plot(dataset$Time, dataset$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", 
           col="black")
      lines(dataset$Time, dataset$Sub_metering_2, col="red")
      lines(dataset$Time, dataset$Sub_metering_3, col="blue")
      legend("topright", bty = "n", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1, 1, 1), 
             col = c("black", "red", "blue"))
      # create fourth plot
      plot(dataset$Time, dataset$Global_reactive_power, type = "l",
           ylab = "Global_reactive_power", xlab = "datetime")
      
      # close png device
      dev.off()
}
