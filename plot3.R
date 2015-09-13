## Course Project 1 :: Plot 3

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

# plot 3
dev.off()  # reset device
with(data, plot(DateTime, Sub_metering_1, type="n", ylab = "Energy sub metetering", xlab=""))
with(data, lines(DateTime,Sub_metering_1, col = "black"))
with(data, lines(DateTime,Sub_metering_2, col = "red"))
with(data, lines(DateTime,Sub_metering_3, col = "blue"))
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# save to file as PNG format
dev.copy(png, file = "plot3.png")
dev.off()
