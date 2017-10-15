Plot3 <- function() {
  
  ##Load required Library
  library(data.table)
  library(lubridate)
  
  ##Load data , Estimate rough range for data required to save time
  
  directory <- "C:/Users/bradk/OneDrive/Coursera/ExploratoryDAAssignment1"
  
  data <- fread(paste(directory,"/household_power_consumption.txt",sep = ""),
                na.strings = "?",
                nrows = 10000, 
                sep = ";", 
                skip = 65000)
  
  cols<- fread(paste(directory,"/household_power_consumption.txt",sep = ""),
               na.strings = "?",
               nrows = 0, sep = ";" )
  
  
  colnames(data)<- names(cols)
  
  ## filter data to specific time period required
  
  filtered<-data[data$Date == "2/2/2007"|data$Date=="1/2/2007",]
  
  ##Add a datetime colum inPOIXct format
  filtered$Date <- dmy(filtered$Date)
  filtered$DateTime <- as.POSIXct(paste(filtered$Date, filtered$Time), format="%Y-%m-%d %H:%M:%S")
  
  ##Set the device
  dev.set(which = 3)
  png("plot3.png", width = 480, height = 480 )
  
  ##Plot Chart
  
  plot(filtered$DateTime,filtered$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering")
  
  lines(filtered$DateTime, filtered$Sub_metering_1, type="l")
  lines(filtered$DateTime, filtered$Sub_metering_2, type="l", col = "red")
  lines(filtered$DateTime, filtered$Sub_metering_3, type="l", col = "blue")
  
  legend("topright", 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col = c("black", "red", "blue"), 
         lwd = 1)
  
  dev.off()
  
  }