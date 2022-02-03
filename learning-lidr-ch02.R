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

# Ch02: Reading, Plotting, Querying, and Validating

# 2.1. Reading LIDAR data using readLAS -----------

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


# 2.2. Validating LIDAR data ----------------------

# Validating lidar data
las_check(tile)


# 2.3. Plotting LIDAR data ------------------------

# Plotting
  ## Basic plotting
  plot(tile)
  plot(tile, color="RGB")
  
  ## Plot las object by scan angle, make the background white, display XYZ axis and Z scale colors
  plot(tile, color = "ScanAngleRank", bg = "white", axis = TRUE, legend = TRUE)
  
  ## Using the trim parameter
  plot(tile, color = "Intensity", trim = 1800, bg = "white")

# Note: Need later chapters for script to work
# Overlays 
overlay <- plot(tile, bg = "white", size = 3)
add_dtm3d(overlay, dtm)

# Advanced 3D rendering
offsets <- plot(tile)
print(offsets)

  # From the Ch02 tutorial on advanced 3D rendering
  LASfile <- system.file("extdata", "MixedConifer.laz", package="lidR")
  las <- readLAS(LASfile, select = "xyzc")

  # Get the location of the trees
  ttops <- find_trees(las, lmf(ws = 5)) 

  # Extract the coordinates of the trees and apply the shift to display the lines
  # in the rendering coordinate system
  x <- coordinates(ttops)[,1] - offsets[1] 
  y <- coordinates(ttops)[,2] - offsets[2] 
  z <- ttops$Z

  # Build a GL_LINES matrix for fast rendering
  x <- rep(x, each = 2)
  y <- rep(y, each = 2)
  tmp <- numeric(2*length(z)) 
  tmp[2*1:length(z)] <- z
  z <- tmp
  M <- cbind(x,y,z)

  # Plot the point cloud
  offsets <- plot(las, bg = "white", size = 3)
  add_treetops3d(offsets, ttops)
  rgl::segments3d(M, col = "black", lwd = 2)


  # Advanced 3D rendering: modified using PD LIDAR data
  las <- readLAS("217_139.las", select = "xyzc")
  
  # Get the location of the trees
  ttops <- find_trees(las, lmf(ws = 5)) 
  
  # Extract the coordinates of the trees and apply the shift to display the lines
  # in the rendering coordinate system
  x <- coordinates(ttops)[,1] - offsets[1] 
  y <- coordinates(ttops)[,2] - offsets[2] 
  z <- ttops$Z
  
  # Build a GL_LINES matrix for fast rendering
  x <- rep(x, each = 2)
  y <- rep(y, each = 2)
  tmp <- numeric(2*length(z)) 
  tmp[2*1:length(z)] <- z
  z <- tmp
  M <- cbind(x,y,z)
  
  # Plot the point cloud
  offsets <- plot(las, bg = "white", size = 3)
  add_treetops3d(offsets, ttops)
  rgl::segments3d(M, col = "black", lwd = 2)
  
# Cross-sections 2D rendering

  # Create 100-m cross-sections: lidR tutorial
  p1 <- c(273357, 5274357) # these are coordinates
  p2 <- c(273542, 5274542) # these are coordinates
  las_tr <- clip_transect(las, p1, p2, width = 4, xz = TRUE)

  # Render cross-section
  ggplot(las_tr@data, aes(X,Z, color = Z)) + 
    geom_point(size = 0.5) + 
    coord_equal() + 
    theme_minimal() +
    scale_color_gradientn(colours = height.colors(50))

  # Two-step cross-section creation: Pulau Padang
  p1 <- c(217008, 139805) # these are coordinates
  p2 <- c(217960, 138990) # these are coordinates
  las_tr <- clip_transect(las, p1, p2, width = 4, xz = TRUE)
  
  plot_crossection <- function(las,
                               p1 = c(min(las@data$X), mean(las@data$Y)),
                               p2 = c(max(las@data$X), mean(las@data$Y)),
                               width = 4, colour_by = NULL)
  {
    colour_by <- enquo(colour_by)
    data_clip <- clip_transect(las, p1, p2, width)
    p <- ggplot(data_clip@data, aes(X,Z)) + geom_point(size = 0.5) + coord_equal() + theme_minimal()
    
    if (!is.null(colour_by))
      p <- p + aes(color = !!colour_by) + labs(color = "")
    
    return(p)
  }
  plot_crossection(las, colour_by = factor(Classification))
