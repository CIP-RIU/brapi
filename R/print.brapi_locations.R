#' print.brapi_locations
#'
#' print method for an object of class brapi_con, which will only display the crop,  database address:port and user
#'
#' @param brapi a brapi_locations object
#' @param ... other print parameters
#' @author Reinhard Simon
# @export
print.brapi_locations <- function(brapi, ...) {
  # Print in console
  missing_geo <- brapi[is.na(brapi$latitude), ]

  cat(paste0("n locations = ", nrow(brapi), "\n"))
  cat(paste0("n locations with missing lat/lon = ", nrow(missing_geo), "\n\n"))

  print.data.frame(brapi)
}
