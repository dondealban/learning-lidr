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

# Load files
tile <- readLAS("217_139.las")
plot(tile)    # plot lidar data
print(tile)   # print lidar data summary
summary(tile) # print lidar data detailed summary




# 3.2. Cloth Simulation Function ------------------




# 3.3. Edge artifacts -----------------------------
