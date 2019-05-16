#CodingInR
#Exploratory Data Analysis Week 1 Project - Plot 3
#Download and construct plot, export to png file

require("lubridate")
require("dplyr")

URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
headerClasses <- c("Date")

#Download dataset if it hasn't been already
if(!file.exists("plotdata.zip")){download.file(URL, destfile = "plotdata.zip")}

#Unzip dataset if it hasn't been already
if(!file.exists("household_power_consumption.txt")){unzip(zipfile = "plotdata.zip")}

#Read data to data frame if it hasn't been already
if(!exists("plotDat")){plotDat <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")}

#Combine date and time into single posix column with lubridate, 
#reduce to the two days we're interested in, order correctly
#(Check first that it hasn't already been done)
if(nrow(plotDat)>3000){
  plotDat<- plotDat %>% mutate(date_time = paste(Date, Time))
  plotDat$date_time <- dmy_hms(plotDat$date_time)
  plotDat<-subset(plotDat, date_time >= "2007-02-01" &  date_time < "2007-02-03")
  plotDat<-plotDat[,c(10,3:9)]
}

#Plot3
png("plot3.png", width = 480, height = 480)
plot(plotDat$date_time,plotDat$Sub_metering_1, 
     xlab =NA,
     type = "l", 
     frame.plot = TRUE,
     ylab = "Energy sub metering"
)
points(plotDat$date_time,plotDat$Sub_metering_2, type = "l", col = "red")
points(plotDat$date_time,plotDat$Sub_metering_3, type = "l", col = "blue")
legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),
       lty=1)
dev.off()
