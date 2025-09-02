
# TreeDetectR

<!-- badges: start -->
<!-- badges: end -->

Detecting and segmenting individual urban trees from LiDAR point cloud data using advanced R-based processing techniques. 

## Installation

  This package can be installed with the following command:
  
``` r
# install.packages("devtools") # if devtools currently not installed
devtools::install_github("fyeqaa/TreeDetectR")

```
## Description

TreeDetectR is an R package designed for detecting and segmenting individual trees from LiDAR point cloud data, especially in urban environments. Using advanced algorithms and geospatial analysis, it provides tools to classify ground points, generate Digital Terrain Models (DTM), normalize heights, build and smooth Canopy Height Models (CHM), detect treetops, and segment tree crowns.

## Usage
Below is a workflow using TreeDetectR for urban tree detection and segmentation from LiDAR data.

```r
library(TreeDetectR)
```

# Step 1: Read and prepare the LAS data
# Reads a LAS file and assigns a CRS if missing.
# Filters points based on height range (30m–80m) to exclude noise.

```r
las <- read_and_prepare_las("path/to/your/file.las")
```

# Step 2: Process the LiDAR data
# Performs a full LiDAR processing pipeline:
# - Classifies ground points
# - Generates a Digital Terrain Model (DTM)
# - Normalizes heights above ground
# - Builds and smooths a Canopy Height Model (CHM)
# - Detects individual tree tops
# - Segments tree crowns

# Set plot = TRUE to visualize each processing step.

```r
result <- process_lidar(las, plot = TRUE)
```

# Step 3: Export tree coordinates to CSV
# Converts detected treetop coordinates to Latitude/Longitude and exports them along with elevation and tree ID to a CSV file.

```r
tree_coords_df <- export_tree_coords(result$treetops, result$chm, filename = "tree_coordinates.csv")
```


