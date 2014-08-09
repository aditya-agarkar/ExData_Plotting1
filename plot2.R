
#--------------------------------------------------------------------------------------------------------------------------
#
# This program will open the text file household_power_consumption.txt and create a data frame for the specific date values.
# Subsequently it creates a line plot for Global Active Power 
#
#--------------------------------------------------------------------------------------------------------------------------
#
#power<-read.table("household_power_consumption.txt", skip=0, sep=";", header=TRUE)
#power$Date<-as.Date(power$Date,"%d/%m/%Y")
#power$Global_reactive_power<-as.numeric(power$Global_reactive_power)
#power$Global_active_power<-as.numeric(power$Global_active_power)
#power<-subset(power,power$Date=="2007-02-01" | power$Date=="2007-02-02")
#hist(power$Global_active_power,col="red",xlab="Global Active Power (Kilowatts",main="Global Active Power")
#
#
inputFile <- "household_power_consumption.txt"
con  <- file(inputFile, open = "r")
power<-list()
current.line <-1
first.row<-1
while (length(oneLine <- readLines(con, n = 1, warn = FALSE)) > 0) {
  myVector <- (strsplit(oneLine, ";"))
  myVector <- array(as.character(myVector[[1]]))
  if(current.line ==1) {
    colnames<-myVector
  } else {
    if (as.Date(myVector[[1]][1],"%d/%m/%Y")=="2007-02-01" | as.Date(myVector[[1]][1],"%d/%m/%Y")=="2007-02-02" ) {
      power<-rbind(power,myVector)
    }
  }

  current.line <- current.line + 1
  #if (current.line > 10000) {
  #    break
  #  }
} 
close(con)
power<-as.data.frame(power)

row.names(power) <- NULL 
colnames(power)<-colnames

power$Global_active_power<-as.numeric(power$Global_active_power)
power$Global_reactive_power<-as.numeric(power$Global_reactive_power)
power$Voltage<-as.numeric(power$Voltage)
power$Global_intensity<-as.numeric(power$Global_intensity)
power$Sub_metering_1<-as.numeric(power$Sub_metering_1)
power$Sub_metering_2<-as.numeric(power$Sub_metering_2)
power$Sub_metering_3<-as.numeric(power$Sub_metering_3)
power$Date<-as.Date(as.character(power$Date),"%d/%m/%Y")
power$timestamp <- as.POSIXct(paste(power$Date,power$Time),format="%Y-%m-%d %H:%M:%S")


plot(power$timestamp,power$Global_active_power,type="l",xlab="",ylab="Global Active Power (Kilowatts)",main="Global Active Power")

