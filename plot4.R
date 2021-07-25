## read the power consumption data set
power_consumption <- read.table("household_power_consumption.txt",sep=";", header = TRUE)

## subset the power consumption data set, transforms GAP to numeric
subset_power_consumption <- subset(power_consumption, power_consumption$Date=="1/2/2007" | power_consumption$Date =="2/2/2007")
GAP <- as.numeric(subset_power_consumption$Global_active_power)

## transform Date and Time variables 
subset_power_consumption$Date <- as.Date(subset_power_consumption$Date, format="%d/%m/%Y")
subset_power_consumption$Time <- strptime(subset_power_consumption$Time, format="%H:%M:%S")
subset_power_consumption[1:1440,"Time"] <- format(subset_power_consumption[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subset_power_consumption[1441:2880,"Time"] <- format(subset_power_consumption[1:1440,"Time"],"2007-02-02 %H:%M:%S")

## local time
Sys.setlocale(category = "LC_TIME", locale="en_US.UTF-8")

## choose device, choose layout, set margins

png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
par(mar = c(4,4,2,1))

## plot the data
plot (x = subset_power_consumption$Time, y = GAP,
      ylab = 'Global Active power (kilowatts)',
      xlab ='  ',
      type = "l")

plot (x= subset_power_consumption$Time, y = subset_power_consumption$Voltage,
      ylab = 'Voltage',
      xlab ='datetime',
      type = "l")

plot (x= subset_power_consumption$Time, y = subset_power_consumption$Sub_metering_1,
      ylab = 'Energy sub metering',
      xlab ='  ',
      type = "l")
legend("topright" , bty = "n", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
lines(x= subset_power_consumption$Time, y = subset_power_consumption$Sub_metering_2, col = "red")
lines(x= subset_power_consumption$Time, y = subset_power_consumption$Sub_metering_3, col = "blue")

plot (x= subset_power_consumption$Time, y = GAP,
      ylab = 'Global_reactive_power',
      xlab ='datetime',
      ylim = range(0,0.5),
      type = "l")

## close device
dev.off()
