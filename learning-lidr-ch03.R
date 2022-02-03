# Learning lidR R package for Airborne LIDAR Data Manipulation and Visualisation
# for Forestry Applications
# 
# Script by:      Jose Don De Alban
# Date created:   25 Jan 2022
# Date modified:  03 Feb 2022

# Load libraries
library(lidR)
library(ggplot2)

# Set working directory
pathPD <- ("/Users/dondealban/Dropbox/Image Processing/Indonesia/APRIL RER/LIDAR Data/pulau padang/")
setwd(pathPD)

# Ch03: Ground Classification

# 3.1. Progressive Morphological Filter -----------

# Lidar data test
LASfile <- system.file("extdata", "Topography.laz", package="lidR")
lasTest <- readLAS(LASfile, select = "xyzrn")
plot(lasTest)    # plot lidar data
print(lasTest)   # print lidar data summary
summary(lasTest) # print lidar data detailed summary
lasTest <- classify_ground(lasTest, algorithm = pmf(ws = 5, th = 3))
plot(lasTest, color = "Classification", size = 3, bg = "white") 

p1 <- c(273420, 5274455)
p2 <- c(273570, 5274460)
plot_crossection(las, p1 , p2, colour_by = factor(Classification))



# Lidar data: Pulau Padang
tile <- readLAS("217_139.las")
plot(tile)    # plot lidar data
print(tile)   # print lidar data summary
summary(tile) # print lidar data detailed summary
plot(tile, color = "Classification", size = 3, bg = "white") 
# Without filtering
  p1 <- c(217300, 139100)
  p2 <- c(217400, 139000)
  plot_crossection(tile, p1 , p2, colour_by = factor(Classification))
# With filtering steps
  ws <- seq(3, 12, 3)
  th <- seq(0.1, 1.5, length.out = length(ws))
  tileNew <- classify_ground(tile, algorithm = pmf(ws = ws, th = th))
  plot_crossection(tileNew, p1 = p1, p2 = p2, colour_by = factor(Classification))


# 3.2. Cloth Simulation Function ------------------




# 3.3. Edge artifacts -----------------------------
