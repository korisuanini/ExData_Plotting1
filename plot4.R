# create four plots in one file 
# first: global active power across the two days
# second: 

plot4 <- function(){
      # first get data, but only if necessary - it is checked whether there is an object 
      # called dataset, and if there is, if it has the right amount of rows. If it has, 
      # the plot is created using the existing dataset-object, if it isn't it is recreated
      if(!exists("dataset") | !nrow(dataset)==2880){
            source("PrepData.R")
            PrepData()
      }
      
      # prepare file to put graphic in, explicitly mentioning the size (identical to default though)
      png(filename = "plot4.png", width = 480, height = 480)
      
      # produce graph to put in png-file
      par(mar = c(5, 4, 4, 2))
      par(mfrow = c(2, 2))
      plot(dataset$Time, dataset$Global_active_power, type = "l", 
           ylab = "Global Active Power", xlab = "")
      plot(dataset$Time, dataset$Voltage, type = "l",
           ylab = "Voltage", xlab = "datetime")
      plot(dataset$Time, dataset$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", 
           col="black")
      lines(dataset$Time, dataset$Sub_metering_2, col="red")
      lines(dataset$Time, dataset$Sub_metering_3, col="blue")
      legend("topright", bty = "n", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1, 1, 1), 
             col = c("black", "red", "blue"))
      plot(dataset$Time, dataset$Global_reactive_power, type = "l",
           ylab = "Global_reactive_power", xlab = "datetime")
      
      # close png device
      dev.off()
}