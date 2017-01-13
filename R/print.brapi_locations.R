#' print.brapi_locations
#'
#' print method for an object of class brapi_con, which will only display the crop,  database address:port and user
#'
#' @param x a brapi_locations object
#' @param ... other print parameters
#' @author Reinhard Simon
# @export
print.brapi_locations <- function(x, ...) {
  # Print in console
  missing_geo <- x[is.na(x$latitude), ]

  cat(paste0("n locations = ", nrow(x), "\n"))
  cat(paste0("n locations with missing lat/lon = ", nrow(missing_geo), "\n\n"))

  print.data.frame(x)
}
