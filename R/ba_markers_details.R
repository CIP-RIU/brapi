#' ba_markers_details
#'
#' Lists markers as result of a search.
#'
#' @param con brapi connection object
#' @param markerDbId character; marker id; \strong{REQUIRED ARGUMENT} with default: ""
#' @param rclass character; default: tibble
#'
#' @return data.frame
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Markers/MarkerDetailsByMarkerDbId.md}{github}
#'
#' @family markers
#' @family genotyping
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
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2 , rclass = rclass, result_level = "result")

    class(out) <- c(class(out), "ba_markers_details")
    show_metadata(res)
    return(out)
  })
}
