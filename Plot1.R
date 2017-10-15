Plot1 <- function() {
  
  
  library(data.table)
  library(lubridate)
  
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

  
  filtered<-data[data$Date == "2/2/2007"|data$Date=="1/2/2007",]
  DateTime <- as.POSIXct(paste(filtered$Date, filtered$Time), format="%Y-%m-%d %H:%M:%S")
                         
  
  ##Set the device
  dev.set(which = 3)
  png("plot1.png", width = 480, height = 480 )
  
  hist(filtered$Global_active_power,
       xlab = "Global Active Power (kilowatts)",
       col = "red",
       main = "Global Active Power")
  
  
  dev.off()
  
    }