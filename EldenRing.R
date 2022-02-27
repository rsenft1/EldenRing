#Sources:
#adapts code from datanovia.com https://www.datanovia.com/en/blog/beautiful-radar-chart-in-r-using-fmsb-and-ggplot-packages/ 
#and the R graph gallery https://www.r-graph-gallery.com/spider-or-radar-chart.html 

# Libraries
library(fmsb)
library(scales)
library(shades)
library(ggthemes)
library(colorRamps)

data <- read.csv("/Path/to/file/EldenRing.csv", header=TRUE, row.names=1)
col_mean <- apply(data, 2, mean)
data <- rbind(rep(16,9), rep(0,9), col_mean, data)

# Colors
tweaked_colors <- rainbow(10)
tweaked_colors <- brightness(tweaked_colors, 0.7)
tweaked_colors <- addmix(tweaked_colors, "orange", 0.3)
tweaked_colors <- brightness(tweaked_colors, 0.85)

# Gray for averages
midgray=160
mygray=rgb(midgray, midgray, midgray, max = 255, alpha = 150)

# Produce a radar-chart for each class compared to average

png("EldenRing1.png", 
    width     = 7,
    height    = 6,
    units     = "in",
    res       = 1200,) 
par(mar = c(1,1,1,1))
par(family = "Palatino")
#par(mfrow = c(3,4))
layout(matrix(c(1,2,3,4,1,5,6,7,1,8,9,12,1,10,11,12),ncol=4),heights=c(2.8,6,6,6))
plot.new()
text(0.5,0.8,"Elden Ring Class Comparison",cex=2)
text(0.5,0.3,"Gray shows the average of starting stats for all classes",cex=1.5)
par(mar = c(0.75,0.75,2,0.75))
for (i in 4:nrow(data)) {
  radarchart(
    data[c(1:3, i), ],
    pfcol = c(mygray,NA),
    pcol= c(NA, tweaked_colors[i-3]), plty = 1, plwd = 3,
    title = row.names(data)[i],
    cglcol="grey80", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
    vlcex=0.8,
  )
}
plot.new()
text(1,0.1,"Graph by Rebecca Senft \nMade in R",adj=1, cex=1.5)
dev.off()

