#' Process Lidar Data Pipeline with Optional Visualization
#'
#' Classifies ground, creates DTM, normalizes height, builds and smooths CHM, detects trees, and segments them.
#' Optionally plots intermediate results.
#'
#' @param las LAS object.
#' @param plot Logical. If TRUE, plots intermediate results. Default is FALSE.
#' @return A list with processed elements: DTM, normalized LAS, CHM, treetops, segmented LAS.
#' @export
process_lidar <- function(las, plot = FALSE) {
  # Ground classification
  las <- lidR::classify_ground(las, algorithm = lidR::csf())

  if (plot) {
    lidR::plot(las, color = "Classification", size = 3, bg = "white", main = "Ground Classification")
  }

  # DTM generation
  dtm <- lidR::rasterize_terrain(las, algorithm = lidR::knnidw(k = 10L, p = 2))

  if (plot) {
    raster::plot(dtm, main = "Digital Terrain Model (DTM)")
  }

  # Height normalization
  nlas <- las - dtm

  if (plot) {
    lidR::plot(nlas, size = 4, bg = "white", main = "Normalized LAS (Height Normalized)")
  }

  # CHM
  chm <- lidR::rasterize_canopy(nlas, res = 1, algorithm = lidR::p2r())

  # Smoothing
  chm_smoothed <- terra::focal(chm, w = matrix(1, 3, 3), fun = median)

  if (plot) {
    raster::plot(chm_smoothed, main = "Smoothed Canopy Height Model")
  }

  # Tree detection
  treetops <- lidR::locate_trees(chm_smoothed, lidR::lmf(ws = 5, hmin = 10))

  if (plot) {
    plot(treetops, col = "red", pch = 16, cex = 0.8, main = "Detected Tree Tops", add = TRUE)
  }

  # Segmentation
  segmented <- lidR::segment_trees(las, algorithm = lidR::dalponte2016(chm = chm_smoothed, treetops = treetops))

  if (plot) {
    lidR::plot(segmented, color = "treeID", main = "Segmented Trees")
  }

  return(list(
    las = las,
    dtm = dtm,
    nlas = nlas,
    chm = chm_smoothed,
    treetops = treetops,
    segmented = segmented
  ))
}
