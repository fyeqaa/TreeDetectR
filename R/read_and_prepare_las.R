#' Read and Prepare LAS Data
#'
#' Reads a LAS file and assigns a CRS if not already set.
#'
#' @param path Path to the LAS file.
#' @param epsg EPSG code to assign if CRS is missing. Default is 25833 (ETRS89 / UTM zone 33N).
#' @return A LAS object with CRS set.
#' @export
read_and_prepare_las <- function(path, epsg = 25833) {
  las <- lidR::readLAS(path, select = "xyzcinr", filter = "-drop_z_below 30 -drop_z_above 80")

  if (is.null(las@crs)) {
    sf::st_crs(las) <- sf::st_crs(epsg)
  }

  return(las)
}
