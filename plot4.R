#download the dataset zip folder:
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data.zip", method="curl")

#unzip the folder:
unzip(zipfile="data.zip")

#read the data
data <- read.table("./household_power_consumption.txt", sep=";", header=T, na.strings="?")
data<-na.omit(data)

#convert date and time variables to date/time classes
df <- within(data, datetime <- as.POSIXlt(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))

#subset dataset to get only data from 2/1/07 and 2/2/07
sdf <- subset(df, as.Date(df$Date, "%d/%m/%Y") == "2007-02-01" | as.Date(df$Date, "%d/%m/%Y") == "2007-02-02")

#create the plots
par(mfcol = c(2,2))

plot(sdf$datetime, sdf$Global_active_power, type="l", ylab = "Global Active Power (KiloWatts)", xlab = "" )

plot(sdf$datetime, sdf$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = "")
lines(sdf$datetime, as.numeric(as.character(sdf$Sub_metering_2)), type = "l", col = "red")
lines(sdf$datetime, as.numeric(as.character(sdf$Sub_metering_3)), type = "l", col = "blue")
legend("topright", pch = "_", col =  c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(sdf$datetime, sdf$Voltage, type="l", ylab = "Voltage", xlab = "datetime")

plot(sdf$datetime, sdf$Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab = "datetime")

#copy to graphical device
dev.copy(png, file = "plot4.png")

#turn off device
dev.off()