
# TreeDetectR

<!-- badges: start -->
<!-- badges: end -->

The goal of TreeDetectR is to provide tools for detecting and segmenting individual urban trees from LiDAR point cloud data using advanced R-based processing techniques. This package facilitates urban forestry research by enabling automated tree detection, crown segmentation, and attribute extraction leveraging LiDAR datasets.

## Installation

You can install the development version of TreeDetectR like so:

``` r
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

remotes::install_github("fyeqaa/TreeDetectR")

```
## Description

TreeDetectR is an R package designed for detecting and segmenting individual trees from LiDAR point cloud data, especially in urban environments. Using advanced algorithms and geospatial analysis, it provides tools to classify ground points, generate Digital Terrain Models (DTM), normalize heights, build and smooth Canopy Height Models (CHM), detect treetops, and segment tree crowns. This package is ideal for urban forestry monitoring, environmental studies, and ecological research.

## Usage

The package read, process, and export tree data from LiDAR LAS files:

## Usage

Below is a typical workflow using TreeDetectR for urban tree detection and segmentation from LiDAR data.

```r
library(TreeDetectR)

# Step 1: Read and prepare the LAS data
# Reads a LAS file and assigns a CRS if missing.
# Filters points based on height range (30m–80m) to exclude noise.
las <- read_and_prepare_las("path/to/your/file.las")

# Step 2: Process the LiDAR data (with visualization enabled)
# Performs a full LiDAR processing pipeline:
# - Classifies ground points
# - Generates a Digital Terrain Model (DTM)
# - Normalizes heights above ground
# - Builds and smooths a Canopy Height Model (CHM)
# - Detects individual tree tops
# - Segments tree crowns
#
# Set plot = TRUE to visualize each processing step.
result <- process_lidar(las, plot = TRUE)

# Step 3: Export tree coordinates to CSV
# Converts detected treetop coordinates to Latitude/Longitude (EPSG:4326)
# and exports them along with elevation and tree ID to a CSV file.
tree_coords_df <- export_tree_coords(result$treetops, result$chm, filename = "tree_coordinates.csv")

```r

