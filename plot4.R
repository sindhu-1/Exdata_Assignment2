#Question 4:
#Across the United States, 
#how have emissions from coal combustion-related sources changed from 1999-2008

# Reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#Subset and obtain the data of coal combustion-related sources
coal1<-SCC[grep("coal",SCC$Short.Name,ignore.case = TRUE),]
coal2<-SCC[grep("coal",SCC$EI.Sector,ignore.case = TRUE),]
coal3<-SCC[grep("coal",SCC$SCC.Level.Three,ignore.case = TRUE),]
coal4<-SCC[grep("coal",SCC$SCC.Level.Four,ignore.case = TRUE),]
coal12 <- rbind(coal1,coal2)
coal12 <- unique(coal12)
coal34 <- rbind(coal3,coal4)
coal34 <- unique(coal34)

coal_all <- rbind(coal12,coal34)
coal_all <- unique(coal_all)

coal_emission<-NEI[NEI$SCC %in% coal_all$SCC,]

coal_emission_years<- aggregate(coal_emission$Emissions,by = list(year=coal_emission$year),sum)

library(ggplot2)

png("plot4.png")

g<-ggplot(coal_emission_years,aes(y=coal_emission_years$x,x=coal_emission_years$year))
g+geom_line()+labs(title=expression(PM[2.5] ~" Emissions from coal combustion-related sources in the US"),
                  x="Years",y=expression("PM"[2.5]*" Emissions in tons"))

dev.off()
