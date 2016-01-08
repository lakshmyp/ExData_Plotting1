## Downloading and Extracting the Data

library(utils)
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileurl, temp)
unzip(temp)  ##folder contents have been unzipped
rm("temp") ## delete temp file  

## Reading txt file into data table. 
mydata <- read.table("household_power_consumption.txt", header = TRUE, sep =";")
mydata2 <- subset(mydata, Date == "1/2/2007" | Date == "2/2/2007") 
mydata2[mydata2 == "?"] = NA  ##change missing values to NA

##changing classes || bit tedious, a function would be faster for more columns, but using this now to save time. 
mydata2$Voltage <- as.numeric (as.character (mydata2$Voltage))
mydata2$Global_active_power <- as.numeric(as.character(mydata2$Global_active_power))
mydata2$Global_reactive_power <- as.numeric(as.character(mydata2$Global_reactive_power))
mydata2$Global_intensity <- as.numeric(as.character(mydata2$Global_intensity))
mydata2$Sub_metering_1 <- as.numeric(as.character(mydata2$Sub_metering_1))
mydata2$Sub_metering_2 <- as.numeric(as.character(mydata2$Sub_metering_2))
mydata2$Sub_metering_3 <- as.numeric(as.character(mydata2$Sub_metering_3))


##Sorting out the dates
correctdate <- paste(as.Date(mydata2$Date, format="%d/%m/%Y"),mydata2$Time, sep = " ")
correctdate <- strptime(correctdatemy, format = "%Y-%m-%d %H:%M:%S")
mydata2$newdate <- correctdate

##Constructing plot 3

par(mfrow = c(2,2)) ##setting up the 2/2 grid
##chart 1,1
with(mydata2, plot(correctdate, Global_active_power, type ="l", ylab ="Global Active Power (kilowatts)", xlab =""))
##chart 1,2
with(mydata2, plot(correctdate, Voltage, type ="l", ylab ="Voltage", xlab ="datetime"))
##chart 2,1
with(mydata2, plot(newdate, Sub_metering_1 , type ="l", ylab = "Energy sub metering", xlab = ""))
with(mydata2, lines(newdate, Sub_metering_2 , type ="l", col = "red"))
with(mydata2, lines(newdate, Sub_metering_3 , type ="l", col = "blue"))
legend("top", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1), lwd = c(2,2), col = c("black","red","blue"), cex = 0.5)
##chart 2,2
with(mydata2, plot(correctdate, Global_reactive_power, type ="l", ylab ="Global_reactive_power", xlab ="datetime"))

dev.copy(png, file = "plot4.png")
dev.off()

dev.copy(png, file = "plot4.png")
dev.off()