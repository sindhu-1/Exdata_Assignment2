#Question 1:
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
#for each of the years 1999, 2002, 2005, and 2008.


# Reading the data
NEI <- readRDS("summarySCC_PM25.rds")

# grouping data by year

emission_by_year <- aggregate(NEI$Emissions,by = list(year=NEI$year),sum)

# Code for Bar plot - plot1.png

png("plot1.png")

barplot(emission_by_year$x,names.arg=emission_by_year$year,
     xlab = "Years",
     ylab= expression(PM[2.5]~" Emission in tons"),
     main=expression(paste("Total ",PM[2.5],"Emissions from all sources in the US")),
     col= rgb(0,0.3,0.7,0.2))

dev.off()

#Alternative- line plot
#png('plot1.png', width=480, height=480)
#plot(emission_by_year$year,emission_by_year$x,xlab = "Years",
#   ylab= expression(PM[2.5]~" Emission in tons"),
#   type='o',pch=19,main=expression(paste("Emissions from ",PM[2.5]," in the US from 1999 to 2008"))
#   ,ylim= range(emission_by_year$x))
#dev.off()