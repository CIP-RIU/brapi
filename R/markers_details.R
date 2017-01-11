
#' markers_details
#'
#' Lists markers as result of a search.
#'
#' @param con brapi connection object
#' @param markerDbId integer; marker id; default: 0
#' @param rclass character; default: tibble
#'
#' @author Reinhard Simon
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Markers/MarkerDetailsByMarkerDbId.md}
#'
#' @return data.frame
#' @family markers
#' @family genotyping
#' @export
markers_details <- function(con = NULL, markerDbId = 0,
                             rclass = "tibble"){
  brapi::check(con, FALSE, "markers/id")
  brp <- get_brapi(con)
  markers = paste0(brp, "markers/", markerDbId )

  try({
    res <- brapiGET(markers, con = con)
    res <- httr::content(res, "text", encoding = "UTF-8")
    out = dat2tbl(res, rclass)
    class(out) = c(class(out), "brapi_markers_details")
    out
  })
}

