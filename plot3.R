#Question 3:
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
#variable, which of these four sources have seen decreases in emissions from 1999-2008 
#for Baltimore City? Which have seen increases in emissions from 1999-2008?
#Use the ggplot2 plotting system to make a plot answer this question.

# Reading the data
NEI <- readRDS("summarySCC_PM25.rds")

#subset data
baltim_city <- subset(NEI,fips == "24510")

baltim_by_type <- aggregate(baltim_city[c("Emissions")], list(year=baltim_city$year,type=baltim_city$type) ,sum)

#Plot
library(ggplot2)

png("plot3.png",width=680,height=480,units="px")

g<-ggplot(baltim_by_type,aes(year,Emissions,col=type))

g+geom_line(stats="identity",size=1)+labs(title=expression(PM[2.5] ~" Emissions from different source types in Baltimore City[1999-2008] "),
                                   x="Years",y=expression("PM"[2.5]*" Emissions in tons"))+
  facet_grid(.~type,space="free")
dev.off()

#Alternate plot
#g+geom_line(size=1.5,alpha=0.5)+
  #labs(title=expression(PM[2.5] ~" Emissions from different sources in Baltimore City[1999-2008] "),
       #x="Years",y=expression("Total PM"[2.5]*" Emissions"))
#dev.off()