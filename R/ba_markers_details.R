#' ba_markers_details
#'
#' Lists markers as result of a search.
#'
#' @param con brapi connection object
#' @param markerDbId character; marker id; default: 0
#' @param rclass character; default: tibble
#'
#' @author Reinhard Simon
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Markers/MarkerDetailsByMarkerDbId.md}{github}
#'
#' @return data.frame
#' @example inst/examples/ex-ba_markers_details.R
#' @family markers
#' @family genotyping
#' @export
ba_markers_details <- function(con = NULL,
                               markerDbId = "0",
                               rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "markers/id")
  stopifnot(is.character(markerDbId))
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  markers <- paste0(brp, "markers/", markerDbId)
  try({
    res <- brapiGET(url = markers, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2 , rclass = rclass)
    class(out) <- c(class(out), "ba_markers_details")
    show_metadata(res)
    return(out)
  })
}
