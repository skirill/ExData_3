checkReadRDS <- function(name)
{
    if (!file.exists(name))
        stop(paste("No file", name, "in", getwd()))
    readRDS(name)
}

NEI <- subset(checkReadRDS("summarySCC_PM25.rds"), fips == "24510")
#SCC <- checkReadRDS("Source_Classification_Code.rds")

NEI.factored <- aggregate(Emissions ~ type + year, sum, data = NEI)

# Plotting
library(ggplot2)
qplot(x=as.character(year), xlab="Year", y=Emissions, data=NEI.factored,
      main = "PM 2.5 in Baltimore City, Mariland, per emission type\n", 
      facets= . ~ type, geom="bar", stat="identity")
ggsave(file="plot3.png")
