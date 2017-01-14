#' chart.brapi_locations
#'
#' print method for an object of class brapi_con, which will only display the crop,  database address:port and user
#'
#' @param x a brapi_locations data.frame/tibble or a numeric vector of longitudes
#' @param ... other plot parameters
#' @import maps
#' @author Reinhard Simon
#' @export
chart.brapi_locations <- function(x, ...) {
    # Print in console
    locs <- x

    with_geo <- locs[!is.na(locs$latitude), ]
    stopifnot(nrow(with_geo) > 0)

    with_geo$latitude <- with_geo$latitude %>% as.numeric()
    with_geo$longitude <- with_geo$longitude %>% as.numeric()

    xr <- range(with_geo$longitude)
    yr <- range(with_geo$latitude)

    maps::map("world", xlim = xr, ylim = yr)
    graphics::title(paste0("Locations from database"))
    graphics::points(x = with_geo$longitude, y = with_geo$latitude, col = "red")
    maps::map.axes()
}
