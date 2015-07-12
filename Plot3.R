#download the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = fileUrl, destfile = "data.zip", method = "curl")
#read data to the dataframe
data <- read.table(unz("data.zip", "household_power_consumption.txt"), header=T, quote="\"", sep=";", colClasses=c("character", "character", rep("numeric",7)), na="?")
#convert th "Date" column types to date
data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
#filter records by Date
dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
filtered_data <- subset(data, Date %in% dates)

png("plot3.png", width=480, height=480)
with(filtered_data, plot(Time, Sub_metering_1,
                         type="l",
                         col="black",
                         ylab="Energy sub metering",
                         xlab=""))
with(filtered_data, lines(Time, Sub_metering_2, col="red"))
with(filtered_data, lines(Time, Sub_metering_3, col="blue"))
with(filtered_data, legend("topright",
            col=c("black", "red", "blue"),
            c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
            lty=1))
dev.off()