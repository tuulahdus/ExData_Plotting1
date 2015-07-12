#download the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = fileUrl, destfile = "data.zip", method = "curl")
#read data to the dataframe
data <- read.table(unz("data.zip", "household_power_consumption.txt"), header=T, quote="\"", sep=";", colClasses=c("character", "character", rep("numeric",7)), na="?")
#convert th "Date" column types to date
data$Date <- as.Date(data$Date, "%d/%m/%Y")
#filter records by Date
dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
filtered_data <- subset(data, Date %in% dates)

png("plot1.png", width=480, height=480)
with(filtered_data, hist(Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     col="red"))
dev.off()