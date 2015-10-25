file.url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(file.url, destfile ="nei.zip",method = "auto")
unzip("nei.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
NEI_sum_Baltimore<-as.data.frame(NEI %>% group_by(year) %>% summarise(Emissions = sum(Emissions[fips=="24510"])))

png(file="plot2.png")
plot(NEI_sum_Baltimore$year,NEI_sum_Baltimore$Emissions,type="l",main="Baltimore City Total Emissions from 1999 to 2008", xlab="Year", ylab="Total PM25 Emissions",xaxt="n")
axis(1, at = NEI_sum_Baltimore$year)
dev.off()

