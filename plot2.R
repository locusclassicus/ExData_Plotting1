## read the power consumption data set
power_consumption <- read.table("household_power_consumption.txt",sep=";", header = TRUE)

## subset the power consumption data set, transform GAP to numeric
subset_power_consumption <- subset(power_consumption, power_consumption$Date=="1/2/2007" | power_consumption$Date =="2/2/2007")
GAP <- as.numeric(subset_power_consumption$Global_active_power)

## transform Date and Time variables 
subset_power_consumption$Date <- as.Date(subset_power_consumption$Date, format="%d/%m/%Y")
subset_power_consumption$Time <- strptime(subset_power_consumption$Time, format="%H:%M:%S")
subset_power_consumption[1:1440,"Time"] <- format(subset_power_consumption[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subset_power_consumption[1441:2880,"Time"] <- format(subset_power_consumption[1:1440,"Time"],"2007-02-02 %H:%M:%S")

## local time
Sys.setlocale(category = "LC_TIME", locale="en_US.UTF-8")

## choose device
png(file = "plot2.png", width = 480, height = 480, units = "px")

## plot the data
plot(subset_power_consumption$Time, GAP, type="l", xlab="", ylab="Global Active Power (kilowatts)") 
title(main="Global Active Power Vs Time")

## quit device
dev.off()
