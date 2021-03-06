if(!file.exists("./data")){
  dir.create("./data")
}

data <- read.csv("./data/household_power_consumption.txt", sep = ";")

# Date was given as dd/mm/yyyy format, replace whole date column and convert it
# from factor to date class.
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# We are only concerned with data from 02/01/2007 to 02/02/2007
# Using the dataes to subset
data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# > dim(data)
# [1] 2880    9
# > unique(data$Date)
# [1] "2007-02-01" "2007-02-02"

# Remove incomplete data.
data <- data[complete.cases(data),]

# Let's combine the date and time column with the paste function and give ita name
dateTime <- paste(data$Date, data$Time)
dateTime <- setNames(dateTime, "datetime")

# Now we remove the existing date and time columns and replace it
data <- data[, !(names(data) %in% c("Date", "Time"))]
data <- cbind(dateTime, data)

# Format dateTime column
data$dateTime <- as.POSIXct(dateTime)
#str(data)


hist(as.numeric(as.character(data$Global_active_power)), main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "orange")

# Code for saving to png

dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
