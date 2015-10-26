file.url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(file.url, destfile ="nei.zip",method = "auto")
unzip("nei.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
columns<-c("year","type")
NEI_sum_Baltimore<-as.data.frame(NEI %>% group_by_(.dots=columns) %>% summarise(Emissions = sum(Emissions[fips=="24510"])))
library(ggplot2)
qplot(year,Emissions,data=NEI_sum_Baltimore,geom=c("point","smooth"),method="lm", facets = type~.)+ggtitle("Baltimore Emissions by Types")+scale_x_continuous(name="Year",breaks=c(1999,2002,2005,2008))

ggsave("plot3.png")

##another way to plot:
## ggplot(baltimore,aes(factor(year), Emissions, fill = type)) +
          geom_bar(stat="identity") + theme_light() + guides(fill=FALSE)+ 
          facet_grid(.~type, scales = "free", space="free") + 
          labs(x="Year", y=expression("Total PM2.5 Emissions (Tons)")) + 
          labs(title = expression( "Annual PM2.5 Emissions for Baltimore by Source Type (1999 to 2008)"))
