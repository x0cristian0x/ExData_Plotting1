# Create directory to hold downloaded data
if (!file.exists("./Project EDA")) 
{dir.create("./Project EDA")}

# Set directory variables
dirMain <- getwd()
path <- file.path(dirMain, "Project EDA")

# Download zip file, If exist Not download
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

# plot 1

hist(Electric$Global_active_power,col = "red",
     xlab = "Global Activate Power (kilowatts)",main = "Global Active Power")
dev.copy(png,"Project EDA/plot1.png",width = 480, height = 480)
dev.off()
