source("./plot1.R")

day <- weekdays(data3$DateTime) 
with(data3, plot(DateTime,Global_active_power,  type = "l", xlab ="", 
                 ylab = "Global Active Power (kilowatts)")) 
