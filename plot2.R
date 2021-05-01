### The purpose of this code file is to create a line plot (and save
### it as a PNG) of global active power for 2007-02-01 and 2007-02-02
### from file: household_power_consumption.txt

# Load the needed packages
library(lubridate)
library(datasets)

# Read the data (from the working directory)
power <- data.table::fread(input = "household_power_consumption.txt",
                           na.strings = "?")

# Change the date format from dd/mm/yyyy to yyyy-mm-dd 
power$Date <- parse_date_time(power$Date, c('dmy', 'ymd'))

# Subset 'power' to just input from 2007-02-01 and 2007-02-02 (Happy Groundhog's Day!)
power_feb07 <- power[(Date >= "2007-01-31") & (Date <= "2007-02-02")]

# Create a new column in 'power_feb07' that is the combined date and time
datetime <- paste(as.Date(power_feb07$Date), power_feb07$Time)
power_feb07$Datetime <- as.POSIXct(datetime)

# Create a line plot of global active power versus time 
with(power_feb07, {
        plot(Global_active_power~Datetime,
             ylab="Global Active Power (kilowatts)", xlab="", type="l")
})

# Save the plot as a PNG file
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()