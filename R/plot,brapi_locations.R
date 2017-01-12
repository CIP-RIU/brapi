#' plot.brapi_locations
#'
#' print method for an object of class brapi_con, which will only display the crop,  database address:port and user
#'
#' @param locs a brapi_locations object
#' @param ... other print parameters
#' @author Reinhard Simon
#' @export
plot.brapi_locations <- function(locs, ...) {
  # Print in console
  with_geo <- locs[!is.na(locs$latitude), ]

  with_geo$latitude <- with_geo$latitude %>% as.numeric()
  with_geo$longitude <- with_geo$longitude %>% as.numeric()

  #dotchart(1:length(missing_geo))
  xr <- range(with_geo$longitude)
  yr <- range(with_geo$latitude)
  maps::map("world", xlim = xr, ylim = yr)
  points(x = with_geo$longitude, y = with_geo$latitude, col = "red")
  maps::map.axes()
}
