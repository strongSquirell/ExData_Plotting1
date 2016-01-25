plot2<- function() {
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
  par(mar = c(4, 4, 2, 2))
  with(dataFebr, plot(dateTime, Global_active_power, type="l",
                      ylab = "Global Active Power(killowatts)", xlab = "", yaxis = F))
  axis(1, at=seq(0,8, by=2), labels=seq(0,8, by=2))
  axis(2)
  dev.copy(png, file = "plot2.png")
  dev.off()
}