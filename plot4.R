
#--------------------------------------------------------------------------------------------------------------------------
#
# This program will open the text file household_power_consumption.txt and create a data frame for the specific date values.
# Subsequently it creates a 2x2 matrix of plots
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


par(mfrow=c(2,2))
plot(power$timestamp,power$Global_active_power,type="l",xlab="",ylab="Global Active Power (Kilowatts)",main="")
plot(power$timestamp,power$Voltage,type="l",xlab="Datetime",ylab="Voltage",ylim=c(min(power$Voltage),max(power$Voltage)),main="")
plot(power$timestamp,power$Sub_metering_1,type="l",xlab="",ylim=c(0,40),ylab="Energy Sub Metering",main="Energy Sub Metering")
par(new=TRUE) 
plot(power$timestamp,power$Sub_metering_2, axes=FALSE, ylim=c(0,40),ylab='', xlab='', bty='c',type="l",col="Red",lwd=4) 
par(new=TRUE) 
plot(power$timestamp,power$Sub_metering_3, axes=FALSE, ylim=c(0,40),ylab='', xlab='', bty='c',type="l",col="Blue",lwd=4) 
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, lwd=4, col=c('black','red', 'blue'), bty='o', cex=.75)
plot(power$timestamp,power$Global_reactive_power,type="l",xlab="Datetime",ylab="Voltage",ylim=c(0,0.50),main="")

