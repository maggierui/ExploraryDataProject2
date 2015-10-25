file.url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(file.url, destfile ="nei.zip",method = "auto")
unzip("nei.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
SCC_coal<-SCC[grepl("Coal",SCC$EI.Sector),]
NEI_coal<-NEI[NEI$SCC %in% SCC_coal$SCC,]

NEI_sum_coal<-as.data.frame(NEI_coal %>% group_by(year) %>% summarise(Emissions = sum(Emissions)))
library(ggplot2)
qplot(year,Emissions,data=NEI_sum_coal,geom=c("point","smooth"),method="lm")+ggtitle("Coal Cobustion-related Emissions")+scale_x_continuous(name="Year",breaks=c(1999,2002,2005,2008))+theme(plot.title = element_text(size = rel(0.7)))
ggsave("plot4.png")