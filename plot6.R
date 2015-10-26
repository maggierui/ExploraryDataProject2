file.url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(file.url, destfile ="nei.zip",method = "auto")
unzip("nei.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
columns<-c("year","fips")
SCC_mobile<-SCC[grepl("Mobile",SCC$EI.Sector),]
NEI_mobile<-NEI[NEI$SCC %in% SCC_mobile$SCC,]

NEI_sum_mobile<-as.data.frame(NEI_mobile %>% group_by_(.dots=columns) %>% summarise(Emissions = sum(Emissions)))
library(ggplot2)
p<-ggplot(subset(NEI_sum_mobile,fips %in% c("24510","06037")))+geom_line(aes(year, Emissions, group=fips, colour=fips))+ggtitle("Emissions by Baltimore and LA")+scale_x_continuous(name="Year",breaks=c(1999,2002,2005,2008))+theme(legend.position="top",plot.title = element_text(size = rel(0.7)))
p+scale_color_hue(name="Location:",labels=c("Los Angeles","Baltimore"))
ggsave("plot6.png")

##another way to plot - more visually appealing
## ggplot(bal_LA, aes(x=factor(year), y=Emissions, fill=city)) +
          geom_bar(aes(fill=year),stat="identity") + 
          facet_grid(scales="free", space="free", .~city) +
          guides(fill=FALSE) + theme_gray() +
          labs(x="year", y=expression("Total PM2.5 Emissions (Tons)")) + 
          labs(ggtitle(expression(atop(" PM2.5 emission changes", 
                      atop(italic("Baltimore Vs. Los Angeles (1999-2008)"), "")))))     
     
     dev.off()
