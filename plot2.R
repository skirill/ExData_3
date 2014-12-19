checkReadRDS <- function(name)
{
    if (!file.exists(name))
        stop(paste("No file", name, "in", getwd()))
    readRDS(name)
}

NEI <- subset(checkReadRDS("summarySCC_PM25.rds"), fips == "24510")
#SCC <- checkReadRDS("Source_Classification_Code.rds")

NEI.factored <- rowsum(NEI$Emissions, NEI$year)

# Plotting
png(file="plot2.png")
par(bg = "transparent")
barplot(NEI.factored[,1], names.arg = row.names(NEI.factored),
        main = "PM 2.5 in Baltimore City, Mariland, ", xlab = "Year", ylab = "Emission")
dev.off()
