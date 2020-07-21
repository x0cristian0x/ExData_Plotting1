# Create directory to hold downloaded data
if (!file.exists("./Project EDA")) 
{dir.create("./Project EDA")}

# Set directory variables
dirMain <- getwd()
path <- file.path(dirMain, "Project EDA")

# Download zip file
if(!file.exists("Electric.zip")){download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                                               destfile = "./Electric.zip",
                                               overwrite = T)
}

# Extract data
unzip(zipfile = ".//Electric.zip", exdir = "./Project EDA")


# Read Data
Electric<-read.csv("Project EDA/household_power_consumption.txt",sep = ";")

# Select Date= 1/2/2007 and 2/2/2007
x<-subset(Electric,Date=="1/2/2007")
y<-subset(Electric,Date=="2/2/2007")

# Join Data
Electric<-rbind(x,y)

# Change type 
Electric$Global_active_power<-as.numeric(Electric$Global_active_power)


# Join Date and time
Electric$Join_Date<-paste(Electric$Date,
                          Electric$Time)
Electric$Join_Date<-strptime(Electric$Join_Date,"%d/%m/%Y %H:%M:%S")

# plot 3
op=par(ps=18)
plot(Electric$Join_Date,Electric$Sub_metering_1,type = "l",
     ylab = "Energy sub metering", xlab = "")
points(Electric$Join_Date,Electric$Sub_metering_2,type = "l",col="red")
points(Electric$Join_Date,Electric$Sub_metering_3,type = "l",col="blue")
legend("topright",
       legend =c( "Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=1,lwd = 1.5
       ,cex = 0.6)
dev.copy(png,"Project EDA/plot3.png",width = 480, height = 480)
dev.off()
par(op)