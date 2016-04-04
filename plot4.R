#READING THE DATA 
tmp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",tmp)
file <- unzip(tmp)
unlink(tmp)
data <- read.table(file, header=TRUE, sep=";")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
dt <- data[(data$Date=="2007-02-01" | data$Date=="2007-02-02"),]
dt$Global_active_power <- as.numeric(as.character(dt$Global_active_power))
dt$Global_reactive_power <- as.numeric(as.character(dt$Global_reactive_power))
dt$Voltage <- as.numeric(as.character(dt$Voltage))
dt$Sub_metering_1 <- as.numeric(as.character(dt$Sub_metering_1))
dt$Sub_metering_2 <- as.numeric(as.character(dt$Sub_metering_2))
dt$Sub_metering_3 <- as.numeric(as.character(dt$Sub_metering_3))
dt <- transform(dt, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

#CONSTRUCTION PLOT4 
plot4 <- function () {
  par(mfrow = c(2,2))
  plot(dt$timestamp, dt$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
  plot(dt$timestamp, dt$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  plot(dt$timestamp, dt$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(dt$timestamp, dt$Sub_metering_2, col = "red")
  lines(dt$timestamp, dt$Sub_metering_3, col = "blue")
  legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1), adj = c(0, 0.5), cex = 0.6, bty = "n")
  plot(dt$timestamp, dt$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
  dev.copy(png, file = "plot4.png", width = 480, height = 480)
  dev.off()
}
plot4()