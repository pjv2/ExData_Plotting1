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

#create the plot
plot(sdf$datetime, sdf$Global_active_power, type="l", ylab = "Global Active Power (KiloWatts)", xlab = "" )

#copy to graphical device
dev.copy(png, file = "plot2.png")

#turn off device
dev.off()