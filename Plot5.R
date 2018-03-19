Balt_mr_CityMV <- subset(NEI, fips == "24510" & type=="ON-ROAD")

BaltimoreMVPM25ByYear <- ddply(Balt_mr_CityMV, .(year), 
                               function(x) sum(x$Emissions))
colnames(BaltimoreMVPM25ByYear)[2] <- "Emissions"
##save the plot to png
png(filename="c:/Coursera/Project5/SecondProject/plot5.png")
qplot(year, Emissions, data=BaltimoreMVPM25ByYear, geom="line") +
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions
                     by Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ 
                                                                   "Emissions (tons)"))
dev.off()
