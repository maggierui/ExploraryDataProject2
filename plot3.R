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