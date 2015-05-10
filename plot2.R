# create plot of global active power across the two days

plot2 <- function(){
      # first get data, but only if necessary - it is checked whether there is an object 
      # called dataset, and if there is, if it has the right amount of rows. If it has, 
      # the plot is created using the existing dataset-object, if it isn't it is recreated
      if(!exists("dataset") | !nrow(dataset)==2880){
            source("PrepData.R")
            PrepData()
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
