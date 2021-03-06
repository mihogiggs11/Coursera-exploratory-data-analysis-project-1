data <- read.table("household_power_consumption.txt",sep = ";",header = FALSE, skip = 1)

names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

sample_data <- subset(data, data$Date=="1/2/2007"|data$Date=="2/2/2007")

sample_data$Date <- as.Date(sample_data$Date, format="%d/%m/%Y")
sample_data$Time <- strptime(sample_data$Time, format="%H:%M:%S")
sample_data[1:1440,"Time"] <- format(sample_data[1:1440,"Time"],"2007-02-01 %H:%M:%S")
sample_data[1441:2880,"Time"] <- format(sample_data[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

plot(sample_data$Time,sample_data$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(sample_data,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(sample_data,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(sample_data,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.copy(png, filename="plot3.png")
dev.off()