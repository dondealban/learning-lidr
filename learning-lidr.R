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
tile <- readLAS("217_139.las")
plot(tile)    # plot lidar data
print(tile)   # print lidar data summary
summary(tile) # print lidar data detailed summary

# Load selected attributes only: using select parameter
tile_xyz  <- readLAS("217_139.las", select = "xyz")  # load XYZ only
plot(tile_xyz)
print(tile_xyz)

tile_xyzi <- readLAS("217_139.las", select = "xyzi") # load XYZ and intensity only
plot(tile_xyzi)
print(tile_xyzi)

# Load selected attributes only: using filter parameter
tile_1ret <- readLAS("217_139.las", filter = "-keep_first") # Read only first returns (faster, memory efficient)
tile_1ret < filter_poi(tile, ReturnNumber == 1L)    # Reads all points before filtering
tile_multifil <- readLAS("217_139.las", filter = "-keep_first -drop_z_below 5 -drop_z_above 50")
plot(tile_1ret)
print(tile_1ret)

# Validating lidar data
las_check(tile)

# Plotting
  ## Basic plotting
  plot(tile)
  plot(tile, color="RGB")
  
  ## Plot las object by scan angle, make the background white, display XYZ axis and Z scale colors
  plot(tile, color = "ScanAngleRank", bg = "white", axis = TRUE, legend = TRUE)
  
  ## Using the trim parameter
  plot(tile, color = "Intensity", trim = 1800, bg = "white")

# Overlays (need Ch4 and Ch7)
overlay <- plot(tile, bg = "white", size = 3)
add_dtm3d(overlay, dtm)


