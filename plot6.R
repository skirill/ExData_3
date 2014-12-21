checkReadRDS <- function(name)
{
    if (!file.exists(name))
        stop(paste("No file", name, "in", getwd()))
    readRDS(name)
}

SCC.veh <- subset(checkReadRDS("Source_Classification_Code.rds"),
              grepl(".*Vehicle.*", EI.Sector))
NEI.veh <- subset(checkReadRDS("summarySCC_PM25.rds"), SCC %in% SCC.veh$SCC)

NEI.veh.bal_la <- subset(NEI.veh, fips %in% c("24510", "06037"))
NEI.veh.bal_la.factored <- aggregate(Emissions ~ fips + year, sum, data = NEI.veh.bal_la)

NEI.veh.bal_la.factored <- within(NEI.veh.bal_la.factored, {
    city = ifelse(fips == "24510", "Baltimore", "Los Angeles")
})

# Plotting
library(ggplot2)
# I don't like what I get with the below call so had to add much code to save to smaller .png
#ggsave(file="plot6.png", scale=0.6)
#preparations for saving
library(grid)
png("plot6.png", width = 640, height = 480)
grid.newpage()
pushViewport(viewport(layout = grid.layout(1, 1)))
#actual plotting
p <- qplot(x = as.character(year), xlab = "Year", y = Emissions, data = NEI.veh.bal_la.factored,
           main = "PM 2.5 from motor vehicles in Baltimore City and Los Angeles County\n", 
           facets = . ~ city, geom = "bar", stat = "identity")
#saving
print(p, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
dev.off()
