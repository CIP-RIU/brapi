#' ba_locations_details
#'
#' Gets details for a location given by a required database identifier.
#'
#' @param con list, brapi connection object
#' @param locationDbId character, the internal database identifier for a
#'                     location of which the details are to be retrieved;
#'                     \strong{REQUIRED ARGUMENT} with default: ""
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @details All standard attributes are always listed. However, attributes in the additionalInfo
#' only when at least one record has data.
#'
#' @return An object of class as defined by rclass containing the location
#'         details.
#'
#' @note Tested against: test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Locations/LocationDetails.md}{github}
#' @example inst/examples/ex-ba_locations_details.R
#' @import tibble
#' @export
ba_locations_details <- function(con = NULL,
                                 locationDbId = "",
                                 rclass = c("tibble", "data.frame",
                                            "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_req(locationDbId)
  check_character(locationDbId)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con) %>% paste0("locations/", locationDbId)
  callurl <- get_endpoint(brp,
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
      out <- locd2tbl(res = cont, rclass = rclass, con = con)
    }
    if (!is.null(out)) {
      class(out) <- c(class(out), "ba_locations_details")
    }
    show_metadata(resp)
    return(out)
  })
}
