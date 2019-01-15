#' ba_markers_details
#'
#' Retrieve marker details.
#'
#' @param con list, brapi connection object
#' @param markerDbId character, the internal database identifier for a marker of
#'                   which the marker details are to be retrieved e.g. "1185";
#'                   \strong{REQUIRED ARGUMENT} with default: ""
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "data.frame"/"list"/"json"
#'
#' @return An object of class as defined by rclass containing the marker details.
#'
#' @note Tested against: test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Markers/MarkerDetailsByMarkerDbId.md}{github}
#'
#' @family markers
#' @family genotyping
#'
#' @example inst/examples/ex-ba_markers_details.R
#'
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @export
ba_markers_details <- function(con = NULL,
                               markerDbId = "",
                               rclass = c("tibble", "data.frame",
                                          "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "markers/id")
  check_character(markerDbId)
  check_req(markerDbId)
  rclass <- match.arg(rclass)

  callurl <- get_brapi(con = con) %>% paste0("markers/", markerDbId)

  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = cont, rclass = rclass, result_level = "result")

    class(out) <- c(class(out), "ba_markers_details")
    show_metadata(resp)
    return(out)
  })
}
