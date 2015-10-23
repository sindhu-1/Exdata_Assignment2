#Question 6:
#Compare emissions from motor vehicle sources in Baltimore City with emissions from 
#motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?


# Reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#subsetting motor vehicle data
motor1<-SCC[grep("vehicle",SCC$Short.Name,ignore.case = TRUE),]
motor2<-SCC[grep("vehicle",SCC$SCC.Level.Three,ignore.case = TRUE),]
motor3<-SCC[grep("vehicle",SCC$SCC.Level.Four,ignore.case = TRUE),]
motor4<-SCC[grep("vehicle",SCC$SCC.Level.Two,ignore.case = TRUE),]
motor_all <- rbind(motor1,motor2,motor3,motor4)
motor_all<-unique(motor_all)

#subsetting data for baltimore city
baltim_city <- subset(NEI,fips == "24510")
motor_emission<-baltim_city[(baltim_city$SCC %in% motor_all$SCC),]

motor_emission_years<- aggregate(motor_emission$Emissions,by = list(year=motor_emission$year),sum)
motor_emission_years <-cbind(motor_emission_years,county="Baltimore city")
#subsetting data for Los Angeles

LA <- subset(NEI,fips=="06037")

LA_motor_emission<-LA[(LA$SCC %in% motor_all$SCC),]

LA_motor_emission_years<- aggregate(LA_motor_emission$Emissions,by = list(year=LA_motor_emission$year),sum)
LA_motor_emission_years<-cbind(LA_motor_emission_years,county="Los Angeles")
#final combined data
BALA<-rbind(motor_emission_years,LA_motor_emission_years)

#plot
library(ggplot2)
png("plot6.png",height = 480,width = 680,units = "px")
g<-ggplot(BALA,aes(year,x,col=county))

g+geom_line(stats="identity",size=1)+labs(title=expression(PM[2.5] ~" Emissions from motor vehicle sources in Baltimore City and Los Angeles[1999-2008] "),
                                          x="Years",y=expression("PM"[2.5]*" Emissions in tons"))+
  facet_grid(.~county,space="free")
dev.off()
