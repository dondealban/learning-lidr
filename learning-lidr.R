# Learning lidR R package for Airborne LIDAR Data Manipulation and Visualisation
# for Forestry Applications
# 
# Script by:      Jose Don De Alban
# Date created:   25 Jan 2022
# Date modified:  

# Load libraries
library(lidR)

# Set working directory
pathPD <- ("/Users/dondealban/Dropbox/Image Processing/Indonesia/APRIL RER/LIDAR Data/pulau padang/")
setwd(pathPD)

# Load files
tile_217_139 <- readLAS("217_139.las")
plot(tile_217_139)    # plot lidar data
print(tile_217_139)   # print lidar data summary
summary(tile_217_139) # print lidar data detailed summary

# Load selected attributes only: using select parameter
tile_xyz  <- readLAS("217_139.las", select = "xyz")  # load XYZ only
plot(tile_xyz)
print(tile_xyz)

tile_xyzi <- readLAS("217_139.las", select = "xyzi") # load XYZ and intensity only
plot(tile_xyzi)
print(tile_xyzi)

# Load selected attributes only: using filter parameter
tile_1ret <- readLAS("217_139.las", filter = "-keep_first") # Read only first returns (faster, memory efficient)
tile_1ret < filter_poi(tile_217_139, ReturnNumber == 1L)    # Reads all points before filtering
tile_multifil <- readLAS("217_139.las", filter = "-keep_first -drop_z_below 5 -drop_z_above 50")
plot(tile_1ret)
print(tile_1ret)

# Validating lidar data
las_check(tile_217_139)
