#' Export Tree Coordinates
#'
#' Converts treetop points to lat/lon and exports to CSV.
#'
#' @param treetops An sf object with tree tops (from locate_trees).
#' @param chm The CHM raster used to extract CRS.
#' @param filename Name of the CSV file to save.
#' @return Data frame of exported tree coordinates.
#' @export
export_tree_coords <- function(treetops, chm, filename = "tree_coordinates.csv") {
  coords <- sf::st_coordinates(treetops)
  z <- treetops$Z
  ids <- treetops$treeID

  df <- data.frame(
    tree_ids = ids,
    X = coords[, 1],
    Y = coords[, 2],
    Z = z
  )

  sf_obj <- sf::st_as_sf(df, coords = c("X", "Y"), crs = sf::st_crs(chm))
  sf_wgs84 <- sf::st_transform(sf_obj, crs = 4326)
  latlon <- sf::st_coordinates(sf_wgs84)

  export_df <- data.frame(
    tree_ids = sf_wgs84$tree_ids,
    Longitude = latlon[, 1],
    Latitude = latlon[, 2],
    Z = sf_wgs84$Z
  )

  utils::write.csv(export_df, filename, row.names = FALSE)
  return(export_df)
}
