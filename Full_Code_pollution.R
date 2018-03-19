
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

## Question 2

Balti_more_Cty <- subset(NEI, fips == "24510")
tot_PM25ByYear <- tapply(Balti_more_Cty$Emissions, Balti_more_Cty$year, sum)

##save the plot to png
png(filename="c:/Coursera/Project5/SecondProject/plot2.png")

plot(names(tot_PM25ByYear), tot_PM25ByYear, type = "l", xlab = "Year", 
     ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Total Baltimore City" ~ PM[2.5] ~ "Emissions by Year"))

dev.off()

##Question 3
typ_PM25ByYear <- ddply(Balti_more_Cty, .(year, type), function(x) sum(x$Emissions))
colnames(typ_PM25ByYear)[3] <- "Emissions"

##save the plot to png
png(filename="c:/Coursera/Project5/SecondProject/plot3.png")

qplot(year, Emissions, data = typ_PM25ByYear, color = type, geom = "line") +
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ 
                       "Emissions by Source Type and Year")) + xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)")) 
dev.off()

## Question 4

CoalCombustionSCC <- subset(SCC, EI.Sector %in% c("Fuel Comb - 
                            Comm/Institutional - Coal",
                                                  "Fuel Comb - Electric Generation - Coal",
                                                  "Fuel Comb - Industrial Boilers, ICEs - Coal"))
# Compare  both Comb and Coal
CoalCombustionSCC1 <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", 
                                                                    Short.Name))

nrow(CoalCombustionSCC)
nrow(CoalCombustionSCC1)
d3 <- setdiff(CoalCombustionSCC$SCC, CoalCombustionSCC1$SCC)
d4 <- setdiff(CoalCombustionSCC1$SCC, CoalCombustionSCC$SCC)
length(d3)
length(d4)
CoalCombustionSCCCodes <- union(CoalCombustionSCC$SCC, CoalCombustionSCC1$SCC)
length(CoalCombustionSCCCodes)
CoalCombustion <- subset(NEI, SCC %in% CoalCombustionSCCCodes)

coalCombustionPM25ByYear <- ddply(CoalCombustion, .(year, type), function(x) 
  sum(x$Emissions))
colnames(coalCombustionPM25ByYear)[3] <- "Emissions"

##save the plot to png
png(filename="c:/Coursera/Project5/SecondProject/plot4.png")
qplot(year, Emissions, data = coalCombustionPM25ByYear, color = type, 
      geom = "line") + ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ 
                                            "Emissions by Source Type and Year")) + xlab("Year") + 
  ylab(expression  ("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()

## Question 5
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

##Question 6
MV <- subset(NEI, (fips == "24510" | fips == "06037") & type=="ON-ROAD")

MV <- transform(MV, region = ifelse(fips == "24510", "Baltimore City", 
                                    "Los Angeles County"))

MVPM25ByYearAndRegion <- ddply(MV, .(year, region), function(x) 
  sum(x$Emissions))
colnames(MVPM25ByYearAndRegion)[3] <- "Emissions"

# normalizing for plot  
Balt1999Emissions <- subset(MVPM25ByYearAndRegion, year == 1999 & 
                              region == "Baltimore City")$Emissions
LAC1999Emissions <- subset(MVPM25ByYearAndRegion, year == 1999 & 
                             region == "Los Angeles County")$Emissions
MVPM25ByYearAndRegionNorm <- transform(MVPM25ByYearAndRegion,
                                       EmissionsNorm = ifelse(region == 
                                                                "Baltimore City",
                                                              Emissions / Balt1999Emissions,
                                                              Emissions / LAC1999Emissions))
##save the plot to png
png(filename="c:/Coursera/Project5/SecondProject/plot6.png")
qplot(year, EmissionsNorm, data=MVPM25ByYearAndRegionNorm, geom="line", 
      color=region) + ggtitle(expression("Total" ~ PM[2.5] ~
                                           "Motor Vehicle Emissions Normalized to 1999 Levels")) + xlab("Year") +
  ylab(expression("Normalized" ~ PM[2.5] ~ "Emissions"))
dev.off()