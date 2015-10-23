#Question 5:
#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset data
baltim_city <- subset(NEI,fips == "24510")
motor1<-SCC[grep("vehicle",SCC$Short.Name,ignore.case = TRUE),]
motor2<-SCC[grep("vehicle",SCC$SCC.Level.Three,ignore.case = TRUE),]
motor3<-SCC[grep("vehicle",SCC$SCC.Level.Four,ignore.case = TRUE),]
motor4<-SCC[grep("vehicle",SCC$SCC.Level.Two,ignore.case = TRUE),]
motor_all <- rbind(motor1,motor2,motor3,motor4)
motor_all<-unique(motor_all)

motor_emission<-baltim_city[(baltim_city$SCC %in% motor_all$SCC),]

motor_emission_years<- aggregate(motor_emission$Emissions,by = list(year=motor_emission$year),sum)

library(ggplot2)

png("plot5.png")

g<-ggplot(motor_emission_years,aes(y=motor_emission_years$x,x=motor_emission_years$year))
g+geom_line()+labs(title=expression(PM[2.5] ~" Emissions from motor vehicle sources in Baltimore City"),
                   x="Years",y=expression("PM"[2.5]*" Emissions in tons"))

dev.off()