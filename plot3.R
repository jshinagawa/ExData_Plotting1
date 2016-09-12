source("./plot2.R")

with (
        data3, { 
                plot(DateTime,Sub_metering_1,  type = "l", xlab ="", ylab = "Energy sub metering") 
                lines(DateTime,Sub_metering_2, col = "red",  type = "l") 
                lines(DateTime,Sub_metering_3, col = "blue", type = "l") 
                legend("topright",  lty = 1, col = c("black", "red", "blue"), 
                       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 
        }
)
