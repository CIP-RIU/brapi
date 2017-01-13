#' plot.brapi_locations
#'
#' print method for an object of class brapi_con, which will only display the crop,  database address:port and user
#'
#' @param x a brapi_locations data.frame/tibble or a numeric vector of longitudes
#' @param y numeric vector of latitudes or null
#' @param ... other plot parameters
#'
#' @author Reinhard Simon
#' @export
plot.brapi_locations <- function(x, y = NULL, ...) {
    # Print in console
    if ("brapi_locations" %in% class(x)) {
        y = locs$latitude
        x = locs$longitude
    }
    
    stopifnot(is.vector(x) & is.numeric(x))
    stopifnot(is.vector(y) & is.numeric(y))
    
    locs = as.data.frame(longitude = x, latitude = y)
    
    with_geo <- locs[!is.na(locs$latitude), ]
    
    with_geo$latitude <- with_geo$latitude %>% as.numeric()
    with_geo$longitude <- with_geo$longitude %>% as.numeric()
    
    # dotchart(1:length(missing_geo))
    xr <- range(with_geo$longitude)
    yr <- range(with_geo$latitude)
    maps::map("world", xlim = xr, ylim = yr)
    graphics::points(x = with_geo$longitude, y = with_geo$latitude, col = "red")
    maps::map.axes()
}
