## read the power consumption data set
power_consumption <- read.table("household_power_consumption.txt",sep=";", header = TRUE)

## subset the power consumption data set, transform GAP to numeric
subset_power_consumption <- subset(power_consumption, power_consumption$Date=="1/2/2007" | power_consumption$Date =="2/2/2007")
GAP <- as.numeric(subset_power_consumption$Global_active_power)

## choose device
png(file = "Plot2.png", width = 480, height = 480, units = "px")

## plot the data
hist(GAP, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

## quit device
dev.off()
