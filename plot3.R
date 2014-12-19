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
# I don't like what I get with the below call so had to add much code to save to smaller .png
#ggsave(file="plot3.png", scale=0.6)
#preparations for saving
library(grid)
png("plot3.png", width = 640, height = 480)
grid.newpage()
pushViewport(viewport(layout = grid.layout(1, 1)))
#actual plotting
p <- qplot(x = as.character(year), xlab = "Year", y = Emissions, data = NEI.factored,
      main = "PM 2.5 in Baltimore City, Mariland, per emission type\n", 
      facets = . ~ type, geom = "bar", stat = "identity")
#saving
print(p, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
dev.off()