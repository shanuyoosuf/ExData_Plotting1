Balti_more_Cty <- subset(NEI, fips == "24510")
tot_PM25ByYear <- tapply(Balti_more_Cty$Emissions, Balti_more_Cty$year, sum)

##save the plot to png
png(filename="c:/Coursera/Project5/SecondProject/plot2.png")

plot(names(tot_PM25ByYear), tot_PM25ByYear, type = "l", xlab = "Year", 
     ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Total Baltimore City" ~ PM[2.5] ~ "Emissions by Year"))

dev.off()
