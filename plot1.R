plot1  <- function() {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  data <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";",
                     na.strings="?", stringsAsFactor = F )
  unlink(temp)
  data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
  dataFebr <- subset(data, Date == as.Date("2007/02/01", format = "%Y/%m/%d") 
                     | as.Date(Date) == as.Date("2007/02/02",format = "%Y/%m/%d"))
  par(mar = c(5, 5, 5, 2))
  with(dataFebr, hist(Global_active_power, col = "red", xlim = c(0,6), ylim = c(0, 1200),
                  xlab = "Global Active Power(killowatts)", main = "Global Active Power", axes = F))
  axis(2, at=seq(0,1200, by=200), labels=seq(0,1200, by=200))
  axis(1, at=seq(0,6, by=2), labels=seq(0,6, by=2))
  dev.copy(png, file = "plot1.png")
  dev.off()
}