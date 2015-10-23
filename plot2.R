#Question2:
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

# Reading the data
NEI <- readRDS("summarySCC_PM25.rds")


#subset data
baltim_city <- subset(NEI,fips == "24510")

baltim_by_year <- tapply(baltim_city$Emissions, baltim_city$year, sum)

png("plot2.png")

plot(names(baltim_by_year),baltim_by_year,
        xlab = "Years",
        ylab= expression(PM[2.5]~" Emission in tons"),
        main=expression(paste(PM[2.5],"Emissions in Baltimore City,Maryland [1999-2008]")),
        type="o",pch = 19)

dev.off()