checkReadRDS <- function(name)
{
    if (!file.exists(name))
        stop(paste("No file", name, "in", getwd()))
    readRDS(name)
}

SCC.veh <- subset(checkReadRDS("Source_Classification_Code.rds"),
              grepl(".*Vehicle.*", EI.Sector))
NEI.veh <- subset(checkReadRDS("summarySCC_PM25.rds"), SCC %in% SCC.veh$SCC)

NEI.veh.bal <- subset(NEI.veh, fips == "24510")
NEI.veh.bal.factored <- rowsum(NEI.veh.bal$Emissions, NEI.veh.bal$year)

# Plotting
png(file="plot5.png")
par(bg = "transparent")
barplot(NEI.veh.bal.factored[,1], names.arg = row.names(NEI.veh.bal.factored),
        main = "PM 2.5 from motor vehicles in Baltimore", xlab = "Year", ylab = "Emission")
dev.off()
