#' locations
#'
#' lists locations available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param locationType string, list of data types
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Locations/ListLocations.md}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family brapi_call
#' @family core
#' @family access
#' @export
locations <- function(locationType = "all", rclass = "tibble") {
  brapi::check(FALSE)
  brp <- get_brapi()
  if(locationType == "all"){
    locations_list = paste0(brp, "locations")
  } else {
    locations_list = paste0(brp, "locations/?locationType=", locationType)
  }

  tryCatch({
    res <- brapiGET(locations_list)
    res <-  httr::content(res, "text", encoding = "UTF-8")
    out = NULL
    if (rclass %in% c("json", "list")) {
      out = dat2tbl(res, rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out = loc2tbl(res, rclass)
    }
    out
  }, error = function(e){
    NULL
  })
}
