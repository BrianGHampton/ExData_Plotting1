### The purpose of this code file is to create a histogram (and save
### it as a PNG) of global active power for 2007-02-01 and 2007-02-02
### from file: household_power_consumption.txt

# Load the lubridate package
library(lubridate)

# Read the data (from the working directory)
power <- data.table::fread(input = "household_power_consumption.txt",
                           na.strings = "?")

# Change the date format from dd/mm/yyyy to yyyy-mm-dd 
power$Date <- parse_date_time(power$Date, c('dmy', 'ymd'))

# Subset 'power' to just input from 2007-02-01 and 2007-02-02 (Happy Groundhog's Day!)
power_feb07 <- power[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# Create a histogram of global active power for the two days and save as a PNG 
png("plot1.png", width=480, height=480)
hist(power_feb07$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()