library(plyr)
library(ggplot2)


## Question 1


## Read data from unzipped files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

tot_EM25ByYear <- tapply(NEI$Emissions, NEI$year, sum)
##save the plot to png
png(filename="c:/Coursera/Project5/SecondProject/plot1.png")

plot(names(tot_EM25ByYear), tot_EM25ByYear, type = "l",
     xlab = "Year", ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))

dev.off()