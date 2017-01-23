#' chart.brapi_locations
#'
#' print method for an object of class brapi_locations, which will only display the crop,  database address:port and user
#'
#' @param x a brapi_locations data.frame/tibble or a numeric vector of longitudes
#' @param ... other plot parameters
#'
#' @author Reinhard Simon
#' @export
chart.brapi_locations <- function(x, ...) {
    prms <- list(...)

    chart_type <- ifelse(!is.null(prms$chart_type),
                         prms$chart_type,
                         "plot")

    locs <- x

    if (chart_type == "plot") {
      graphics::plot(x = locs$longitude, y = locs$latitude)
    }

    if (chart_type == "map") {
      can_map <- exists("worldMapEnv")

     if (can_map) {
        maps::map()
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
     } else {
      message(paste0("Please install and load: library(maps)"))
    }
   }


}


#' chart.brapi_genomemaps
#'
#' print method for an object of class brapi_brapi_genomemaps, which will only display the crop,  database address:port and user
#'
#' @param x a brapi_locations data.frame/tibble or a numeric vector of longitudes
#' @param ... other plot parameters
#'
#' @author Reinhard Simon
#' @export
chart.brapi_genomemaps <- function(x, ...) {
  prms <- list(...)
  stopifnot(!is.null(x$markerCount & !is.null(x$mapDbId)))
  chart_type <- ifelse(!is.null(prms$chart_type),
                       prms$chart_type,
                       "plot")


  if (chart_type == "plot") {
    ttl <- paste0("Comparative view of genome maps")
    graphics::barplot(x$markerCount,
                      horiz = T,
                      axisnames = T,
                      names.arg =  x$mapDbId,
                      las = 1,
                      main = ttl,
                      xlab = "Number of markers")
  }

  if (chart_type == "map") {
  }

}



#' chart.brapi_genomemaps_details
#'
#' print method for an object of class brapi_brapi_genomemaps_details, which will only display the crop,  database address:port and user
#'
#' @param x a brapi_genomemaps_details_data data.frame/tibble or a numeric vector of longitudes
#' @param ... other plot parameters
#'
#' @author Reinhard Simon
#' @export
chart.brapi_genomemaps_details <- function(x, ...) {
  prms <- list(...)
  chart_type <- ifelse(!is.null(prms$chart_type),
                       prms$chart_type,
                       "plot")


  if (chart_type == "plot") {
    ttl <- paste0("Linkage groups")
    cnid <- which(stringr::str_detect(colnames(x), "Id"))
    graphics::barplot(x$maxPosition,
                      horiz = T,
                      axisnames = T,
                      names.arg =  x[[ c(cnid)]],
                      las = 1,
                      main = ttl,
                      xlab = "Maximum length of linkage group")
  }

  if (chart_type == "map") {
  }

}
