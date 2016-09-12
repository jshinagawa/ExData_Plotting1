source("./plot3.R")

par(mfrow = c(2,2)) 
with (
        data3, {  
                plot(DateTime,Global_active_power,  type = "l", xlab ="", 
                     ylab = "Global Active Power (kilowatts)") 
                plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage") 
                { 
                        plot(DateTime,Sub_metering_1,  type = "l", xlab ="", 
                 	     ylab = "Energy sub metering") 
                 	lines(DateTime,Sub_metering_2, col = "red",  type = "l") 
                 	lines(DateTime,Sub_metering_3, col = "blue", type = "l") 
                 	legend("topright",  lty = 1, bty ='n', cex = 0.75, 
                 	       col = c("black", "red", "blue"), 
                 	       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 
                } 
                plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime", 
                     ylab = "Global_reactive_power", cex.axis = 0.8) 
 	}
) 
