## Course Project 1 :: Plot 4

# change this to where the data file is located 
setwd("O:/Personal/Coursera/4- Exploratory Data Analysis/Course Project 1")

# read the entire file and then subset it to dates between 2007-02-01 and 2007-02-02
require(data.table)
all_data <- fread("household_power_consumption.txt", sep = ";", na.strings ="?")
data <- subset(all_data, Date == "1/2/2007" | Date == "2/2/2007")

# convert data types
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# if you don't have the package lubridate installed, remove the comment mark
# install.packages("lubridate")
library(lubridate)

data$DateTime <- dmy_hms(paste(data$Date,data$Time, sep=" "))
data$Weekday <- as.factor(weekdays(as.Date(data$Date, "%d/%m/%Y")))


# plot 4
dev.off()  # reset device
par(mfcol = c(2,2))

# plot A
with(data, plot(DateTime, Global_active_power, type="n", ylab = "Global Active Power", xlab=""))
with(data, lines(DateTime, Global_active_power))

# plot B
with(data, plot(DateTime, Sub_metering_1, type="n", ylab = "Energy sub metetering", xlab=""))
with(data, lines(DateTime,Sub_metering_1, col = "black"))
with(data, lines(DateTime,Sub_metering_2, col = "red"))
with(data, lines(DateTime,Sub_metering_3, col = "blue"))
legend("topright", lty=1, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# plot C
with(data, plot(DateTime, Voltage, type="n", ylab = "Voltage", xlab="datetime"))
with(data, lines(DateTime, Voltage))

# plot D
with(data, plot(DateTime, Global_reactive_power, type="n", ylab = "Global_reactive_power", xlab="datetime"))
with(data, lines(DateTime, Global_reactive_power))

# save to file as PNG format
dev.copy(png, file = "plot4.png")
dev.off()

# the chart with the legend looks better if made a little bigger
dev.copy(png, file = "plot4_720.png", width=720, height=720)
dev.off()

