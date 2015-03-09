setwd("U:/Profile/Documents/R/WORK/Exploratory Data Analysis")

##load only the necessary data using fread
#create "data" directory if not exist
	library("data.table")
	library("dplyr")
	if (!file.exists("data")) {
		dir.create("data")
	}

#download the zipped data file from the provided website and read in to R by unzipping it. 
	fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	infile <- "./data/HPC.zip"
	download.file(fileUrl, destfile = infile)

#only the data dated 2007-02-01 to 2007-02-02.
#2,075,259 data collected over 47months period between Dec 2006-Nov 2010
#Try to reduce the data from month to date by 
	#1. extract data 3rd out of 47 months
	#2. convert Date/Time classed as suggested
	#3. subset the data by matching the date to 2007-02-01 and 2007-02-02

#1. 
	tndata <- 2075259
	tm <- 47
	ndpm <- round(tndata/tm)

	#Since the data is at the begining of the month, take data around end of Jan 2007.
	#Conservatively add +/- 1/2 month range to account for counting error from a leap year and shorter monthss.

	endJan2007 <- 2*ndpm	
	frow <- (endJan2007 - 0.5* ndpm) 
	lrow <- (endJan2007 + 0.5* ndpm) 

	unzip <- function (x) {
		unz(x, "household_power_consumption.txt")
	}

	data <- read.csv(
		unzip(infile), sep = ";", nrows=ndpm, na.strings = c("NA","?"), 
		skip = frow, header = TRUE, quote = "\"", check.names = FALSE
	)
	names(data) <- names(read.csv(unzip(infile), sep = ";", nrows=1, na.strings = c("NA","?"), skip = 0  ))

#2
	dates <- as.Date(data$Date, "%d/%m/%Y")
	
#3
	idt <- dates == "2007-02-01"| dates == "2007-02-02"
	data2 <- data[idt,]	
	x <- paste(data2$Date, data2$Time)
	DateTime <- strptime(x, "%d/%m/%Y %H:%M:%S", tz = "GMT")
	data2$DateTime <- DateTime
	data3 <- select( data2, -(Date:Time))
	
## 
	day <- weekdays(data3$DateTime)
	with(data3, plot(DateTime,Global_active_power,  type = "l", xlab ="", ylab = "Global Active Power (kilowatts)"))

