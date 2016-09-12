setwd("C:/Users/161205/Documents/R/CourseraWork/Exploratory Data Analysis/Assignments_2016")

##load only the necessary data using fread
#create "data" directory if not exist
library("data.table")
library("dplyr")

if (!file.exists("data")) {
	dir.create("data")
}

#download the zipped data file from the provided website and read in to R by unzipping it. 
fileUrl <- paste0("http://d396qusza40orc.cloudfront.net/",
        "exdata%2Fdata%2Fhousehold_power_consumption.zip")
infile <- "./data/HPC.zip"
download.file(fileUrl, destfile = infile)

#Import that data only dated between 2007-02-01 and 2007-02-02.
#2,075,259 data collected over 47months period between Dec 2006-Nov 2010
#Try to reduce the data from month to date by 
#1. extract data 3rd out of 47 months
#2. convert Date/Time classed as suggested
#3. subset the data by matching the date to 2007-02-01 and 2007-02-02

#1. Conservatively add +/- 1 month range to account for counting error from a leap year
#and shorter months.
ttlnmbrdt <- 2075259    #total number of data
ttlnmbrmnth <- 47       #total number of months
nmbrdtpm <- round(ttlnmbrdt/ttlnmbrmnth)    #number of the data per a month

endJan2007 <- 2*nmbrdtpm	
frow <- (endJan2007 - nmbrdtpm) 
lrow <- (endJan2007 + nmbrdtpm) 

unzip <- function (x) {
	unz(x, "household_power_consumption.txt")
}

data <- read.csv(
	#unzip(infile), sep = ";", nrows=nmbrdtpm, na.strings = c("NA","?"),
	unz(infile, "household_power_consumption.txt"), sep = ";", na.strings = c("NA","?"), 
	skip = frow, header = FALSE, nrows=nmbrdtpm, quote = "\"", 
	#na.strings = c("NA","?"), nrows=nmbrdtpm, quote = "\"", 
	stringsAsFactors = FALSE, check.names = TRUE, as.is = TRUE
)

names(data) <- names(read.csv(unzip(infile), sep = ";", nrows=1, na.strings = c("NA","?"), skip = 0  ))

#2 Convert Date/Time classed as suggested
dates <- as.Date(data$Date, "%d/%m/%Y")
	
#3 Subset the data by matching the date to 2007-02-01 and 2007-02-02
idt <- dates == "2007-02-01"| dates == "2007-02-02"
data2 <- data[idt,]	
x <- paste(data2$Date, data2$Time)
DateTime <- strptime(x, "%d/%m/%Y %H:%M:%S", tz = "GMT")
data2$DateTime <- DateTime
data3 <- select( data2, -(Date:Time))
	
## plot histogram of "Global Active Power"
hist(data3$Global_active_power, col = "Red",main = "Gloval Active Power", 
     xlab = "Global Active Power (kilowatts)")
