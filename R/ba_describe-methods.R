#' ba_describe.ba_locations
#'
#' describe method for an object of class brapi_con, which will only display the crop, database address:port and user
#'
#' @param x a brapi_locations object
#' @param ... other print parameters
#' @author Reinhard Simon
#' @example inst/examples/ex-describe.R
#' @family brapiutils
#' @export
ba_describe.ba_locations <- function(x, ...) {
  # Print in console
  missing_geo <- x[is.na(x$latitude), ]
  cpl <- nrow(x)
  mis <- nrow(missing_geo)
  pct <- mis / cpl * 100
  cat(paste0("n locations = ", cpl, "\n"))
  cat(paste0("n locations with missing lat/lon = ", mis, " (", pct, "%) \n\n"))
  return(invisible())
}
