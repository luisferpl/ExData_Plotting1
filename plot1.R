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

#CONSTRUCTION PLOT1
plot1 <- function () {
  hist(dt$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
  dev.copy(png, file = "plot1.png", width = 480, height = 480)
  dev.off()
}
plot1()

