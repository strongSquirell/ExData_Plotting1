plot4<- function() {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  df <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";",
                   na.strings="?", stringsAsFactor = F )
  unlink(temp)
  df1 <- as.data.frame(df)
  dateTime <- paste(df1$Date, df1$Time)
  dateTime <- strptime(dateTime, format="%d/%m/%Y %H:%M:%S")
  df1$Date <- as.Date(df1$Date, format = "%d/%m/%Y")
  df1 <-cbind(df1,dateTime)
  dataFebr <- subset(df1, Date == as.Date("2007/02/01", format = "%Y/%m/%d") 
                     | as.Date(Date) == as.Date("2007/02/02",format = "%Y/%m/%d"))
  Sys.setlocale("LC_TIME", "us")
  par(mar = c(4, 4, 2, 2), mfrow = c(2,2))
  with(dataFebr, plot(dateTime, Global_active_power, type="l",
                      ylab = "Global Active Power", xlab = ""))
  with(dataFebr, plot(dateTime, Voltage, type="l",
                      ylab = "Voltage", xlab = "datetime"))
  with(dataFebr, plot(dateTime, Sub_metering_1, type="l",
                      ylab = "Energy sub metering", xlab = ""))
  lines(dataFebr$dateTime, dataFebr$Sub_metering_2,col="red")
  lines(dataFebr$dateTime, dataFebr$Sub_metering_3,col="blue")
  legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         lty = 1, col=c("black", "red", "blue"), cex = 0.8)
  with(dataFebr, plot(dateTime, Global_reactive_power, type="l",
                      ylab = "Global_reactive_power", xlab = "datetime"))
  dev.copy(png, file = "plot4.png")
  dev.off()
}