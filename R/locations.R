#' locations
#'
#' lists locations available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param locationType string, list of data types
#' @param page integer; default 0
#' @param pageSize integer; default 1000
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Locations/ListLocations.md}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family brapi_call
#' @family phenotyping
#' @export
locations <- function(locationType = "all", page = 0, pageSize = 1000, rclass = "tibble") {
  brapi::check(FALSE, "locations")
  brp <- get_brapi()
  locations_list = paste0(brp, "locations/?")

  locationType = ifelse(locationType != "all", paste0("locationType=", locationType, "&"), "")
  page = ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  pageSize = ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")

  locations_list = paste0(locations_list, page, pageSize, locationType)


  try({
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
  })
}
