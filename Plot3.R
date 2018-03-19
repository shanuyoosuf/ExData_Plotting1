typ_PM25ByYear <- ddply(Balti_more_Cty, .(year, type), function(x) sum(x$Emissions))
colnames(typ_PM25ByYear)[3] <- "Emissions"

##save the plot to png
png(filename="c:/Coursera/Project5/SecondProject/plot3.png")

qplot(year, Emissions, data = typ_PM25ByYear, color = type, geom = "line") +
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ 
                       "Emissions by Source Type and Year")) + xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)")) 
dev.off()