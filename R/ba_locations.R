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
                         locationType = "",
                         pageSize = 1000,
                         page = 0,
                         rclass = c("tibble", "data.frame",
                                    "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(locationType)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con) %>% paste0("locations")
  callurl <- get_endpoint(brp,
                          locationType = locationType,
                          pageSize = pageSize,
                          page = page
                          )

  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = cont, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out <- loc2tbl(res = cont, rclass = rclass, con = con)
    }
    if (!is.null(out)) {
      class(out) <- c(class(out), "ba_locations")
    }
    show_metadata(resp)
    return(out)
  })
}
