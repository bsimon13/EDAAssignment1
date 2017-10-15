Plot4 <- function(){
  
  ##Load required Libraries
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
  png("plot4.png", width = 480, height = 480 )

  ##Plot Chart
  par(mar = c(5,4,1,2))
  par(mfrow=c(2,2))
  
  ##chart 1
  plot(filtered$DateTime, filtered$Global_active_power,
       type = "l", 
       xlab = "",
       ylab = "Global Active Power (kilowatts)")
  
  
  ##chart 2
  plot(filtered$DateTime, filtered$Voltage,
          type = "l", 
          xlab = "datetime",
          ylab = "Voltage")
  
  ##chart3
  plot(filtered$DateTime,filtered$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering")
  
  lines(filtered$DateTime, filtered$Sub_metering_1, type="l")
  lines(filtered$DateTime, filtered$Sub_metering_2, type="l", col = "red")
  lines(filtered$DateTime, filtered$Sub_metering_3, type="l", col = "blue")
  
  legend("topright", 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col = c("black", "red", "blue"), 
         lwd = 1)
  
  ##chart4
  plot(filtered$DateTime, filtered$Global_reactive_power,
       type = "h", 
       xlab = "datetime",
       ylab = "Global_reactive_poower")
  
  ##Switch off the device
  dev.off()
  
  
}