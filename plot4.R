checkReadRDS <- function(name)
{
    if (!file.exists(name))
        stop(paste("No file", name, "in", getwd()))
    readRDS(name)
}

SCC.coalcomb <- subset(checkReadRDS("Source_Classification_Code.rds"),
              grepl(".*Comb.*Coal.*", EI.Sector))
NEI.coalcomb <- subset(checkReadRDS("summarySCC_PM25.rds"), SCC %in% SCC.coalcomb$SCC)

NEI.coalcomb.factored <- rowsum(NEI.coalcomb$Emissions, NEI.coalcomb$year)

# Plotting
png(file="plot4.png")
par(bg = "transparent")
barplot(NEI.coalcomb.factored[,1], names.arg = row.names(NEI.coalcomb.factored),
        main = "PM 2.5 from coal combustion-related sources", xlab = "Year", ylab = "Emission")
dev.off()
