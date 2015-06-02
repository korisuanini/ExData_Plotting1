# create plot of global active power across the two days


plot2 <- function(){
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
      png(filename = "plot2.png", width = 480, height = 480)
      
      # produce graph to put in png-file
      par(mar = c(4, 4, 4, 2))
      plot(dataset$Time, dataset$Global_active_power, type = "l", 
           ylab = "Global Active Power (kilowatts)", xlab = "")
      
      # close png device
      dev.off()
      
}
