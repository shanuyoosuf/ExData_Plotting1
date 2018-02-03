tbl <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Changing the format of date
tbl$Date <- as.Date(tbl$Date, "%d/%m/%Y")

## Filtering the data set
tbl <- subset(tbl,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
tbl <- tbl[complete.cases(tbl),]

## Combine Date and Time column
dateTime <- paste(tbl$Date, tbl$Time)

dateTime <- setNames(dateTime, "DateTime")

tbl <- tbl[ ,!(names(tbl) %in% c("Date","Time"))]

## Add DateTime column
tbl <- cbind(dateTime, tbl)

## Format dateTime Column
tbl$dateTime <- as.POSIXct(dateTime)

