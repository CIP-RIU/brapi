#' locations
#'
#' lists locations available on a brapi server
#'
#' @param con brapi connection object
#' @param rclass string; default: tibble
#' @param locationType string, list of data types
#' @param page integer; default 0
#' @param pageSize integer; default 1000
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Locations/ListLocations.md}(github)
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
# @family phenotyping
#' @export
locations <- function(con = NULL, locationType = "all", page = 0, pageSize = 1000, rclass = "tibble") {
  brapi::check(con, FALSE, "locations")
  brp <- get_brapi(con)
  locations_list <- paste0(brp, "locations/?")

  locationType <- ifelse(locationType != "all", paste0("?locationType=", locationType, "&"), "")
  page <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  pageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")
  # if(locationType == ""){
  #   page <- ""
  #   pageSize <- ""
  # }

  locations_list <- paste0(locations_list, page, pageSize, locationType)


  try({
    res <- brapiGET(locations_list, con = con)
    res <-  httr::content(res, "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res, rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      #if(con$bms) {
        out <- jsonlite::fromJSON(res, simplifyDataFrame = TRUE, flatten = TRUE)$result$data
        if(rclass == "tibble") out <- tibble::as_tibble(out)
      # } else {
      #   out <- loc2tbl(res, rclass)
      # }

    }
    class(out) <- c( "brapi_locations", class(out))
    out
  })
}
