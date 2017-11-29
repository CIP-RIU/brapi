#' ba_locations
#'
#' Lists locations available on a brapi server.
#'
#' @note All standard attributes are always listed. However, attributes in the additionalInfo only when at least one record has data.
#'
#' @param con brapi connection object
#' @param rclass character; default: tibble
#' @param locationType character, list of data types
#' @param page integer; default 0
#' @param pageSize integer; default 100
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Locations/ListLocations.md}{github}
#' @example inst/examples/ex-ba_locations.R
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
# @family phenotyping
#' @export
ba_locations <- function(con = NULL,
                         locationType = "all",
                         page = 0,
                         pageSize = 1000,
                         rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "locations")
  stopifnot(is.character(locationType))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  # fetch the url of the brapi implementation of the database
  brp <- get_brapi(brapi = con)
  # generate the brapi call specific url
  # locations_list <- paste0(brp, "locations/?") # TO BE CONSIDERED FOR VERSION 2
  locations_list <- paste0(brp, "locations?")
  plocationType <- ifelse(locationType != "all", paste0("locationType=", gsub(" ", "%20", locationType), "&"), "")
  ppage <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  ppageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")
  if (page == 0 & pageSize == 1000) {
    ppage <- ""
    ppageSize <- ""
  }
  # modify brapi call specific url to include locationType and pagenation
  locations_list <- sub("[?&]$",
                        "",
                        paste0(locations_list,
                               ppage,
                               ppageSize,
                               plocationType))
  try({
    res <- brapiGET(url = locations_list, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out <- loc2tbl(res = res, rclass = rclass, con = con)
    }
    if (!is.null(out)) {
      class(out) <- c(class(out), "ba_locations")
    }
    return(out)
  })
}
