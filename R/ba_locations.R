#' ba_locations
#'
#' Lists locations available on a brapi server.
#'
#' @param con list, brapi connection object
#' @param locationType character, filter by a specified location type.
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @details All standard attributes are always listed. However, attributes in the additionalInfo
#' only when at least one record has data.
#'
#' @return An object of class as defined by rclass containing locations.
#'
#' @note Tested against: BMS, sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Locations/ListLocations.md}{github}
#' @example inst/examples/ex-ba_locations.R
#' @import tibble
#' @export
ba_locations <- function(con = NULL,
                         locationType = "all",
                         pageSize = 1000,
                         page = 0,
                         rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "locations")
  stopifnot(is.character(locationType))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  # fetch the url of the brapi implementation of the database
  brp <- get_brapi(con = con)
  # generate the brapi call specific url
  locations_list <- paste0(brp, "locations?")
  plocationType <- ifelse(locationType != "all",
                          paste0("locationType=",
                                gsub(" ", "%20", locationType), "&"), "")
  ppageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize,
                                                   "&"), "")
  ppage <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  if (pageSize == 1000 & page == 0) {
    ppageSize <- ""
    ppage <- ""
  }
  # modify brapi call specific url to include locationType and pagenation
  callurl <- sub("[/?&]$",
                 "",
                 paste0(locations_list,
                        plocationType,
                        ppageSize,
                        ppage))
  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out <- loc2tbl(res = res2, rclass = rclass, con = con)
    }
    if (!is.null(out)) {
      class(out) <- c(class(out), "ba_locations")
    }
    show_metadata(res)
    return(out)
  })
}
