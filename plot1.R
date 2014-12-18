checkReadRDS <- function(name)
{
    if (!file.exists(name))
        stop(paste("No file", name, "in", getwd()))
    readRDS(name)
}

NEI <- checkReadRDS("summarySCC_PM25.rds")
SCC <- checkReadRDS("Source_Classification_Code.rds")

NEI.factored <- rowsum(NEI$Emissions, NEI$year)

# Plotting
png(file="plot1.png")
par(bg = "transparent")
barplot(NEI.factored[,1], names.arg = row.names(NEI.factored),
        main = "PM 2.5", xlab = "Year", ylab = "Emission")
dev.off()
